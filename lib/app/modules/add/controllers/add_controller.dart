import 'dart:convert';
import 'dart:io';

import 'package:blogg_apps/app/data/controller/post_controller.dart';
import 'package:blogg_apps/app/modules/widgets/show_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../data/controller/connection.dart';
import '../../../data/controller/user_controller.dart';

class AddController extends GetxController {
  final PostController postController = PostController();
  final TextEditingController headerController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final ConnectionController connectionController =
      Get.put(ConnectionController());
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final dateFormatter = DateFormat('yyyy-MM-dd');
  final ImagePicker _picker = ImagePicker();

  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  Rx<XFile?> selectedVideo = Rx<XFile?>(null);
  VideoPlayerController? videoPlayerController;
  bool isSyncing = false; // Flag untuk mencegah sync dobel

  final box = GetStorage();
  var isVideoPlaying = false.obs;

  var selectedVideoPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
    ever(connectionController.isOnline, (bool isOnline) {
      if (isOnline) {
        syncOfflinePosts(); // Jalankan hanya saat koneksi online
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    clearAll();
    super.onClose();
  }

  Future<void> openCameraImg() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> openCameraVid() async {
    try {
      final XFile? vid = await _picker.pickVideo(source: ImageSource.camera);
      if (vid != null) {
        selectedVideo.value = vid;
        box.write('videoPath', vid.path);
        videoPlayerController = VideoPlayerController.file(File(vid.path));
        await videoPlayerController!.initialize();
        videoPlayerController!.play();
        isVideoPlaying.value = true;
        update();
      } else {
        selectedVideo.value = null;
        videoPlayerController = null;
        isVideoPlaying.value = false;
        update();
      }
    } catch (e) {
      print("Error saat mengambil video: $e");
    }
  }

  Future<void> displayOptionsDialog(bool textArea, String title, String desc,
      VoidCallback onPressedImg, VoidCallback onPressedVid) async {
    return Get.dialog(ShowOptions(
      title: title,
      desc: desc,
      onPressedImg: onPressedImg,
      onPressedVid: onPressedVid,
    ));
  }

  void _loadStoredData() {
    selectedVideoPath.value = box.read('videoPath') ?? '';
    if (selectedVideoPath.value.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.file(File(selectedVideoPath.value))
            ..initialize().then(
              (_) {
                videoPlayerController!.play();
                isVideoPlaying.value = true;
                update();
              },
            );
    }
  }

  void play() {
    videoPlayerController?.play();
    isVideoPlaying.value = true;
    update();
  }

  void pause() {
    videoPlayerController?.pause();
    isVideoPlaying.value = false;
    update();
  }

  void togglePlayPause() {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
        isVideoPlaying.value = false;
      } else {
        videoPlayerController!.play();
        isVideoPlaying.value = true;
      }
      update();
    }
  }

  Future<void> savedArticles(String title, String tag) async {
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
        FirebaseStorage.instance.ref().child('contentImg/$imageName.jpg');

    final DateTime now = DateTime.now();
    String date = dateFormatter.format(now);

    Map<String, dynamic> postData = {
      "username": _prefs.getString('username'),
      "title": title,
      "tag": tag,
      "header": headerController.text,
      "content": contentController.text,
      "date": date,
      "imagePath": selectedImage.value?.path,
    };

    if (connectionController.isOnline.value) {
      try {
        var uploadTask = storageRef.putFile(File(selectedImage.value!.path));
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();

        postController.addPost(
          postData["username"],
          postData["title"],
          postData["tag"],
          postData["header"],
          postData["content"],
          postData["date"],
          downloadUrl,
        );

        Get.snackbar('Success', 'Berhasil menambahkan gambar');
      } catch (e) {
        Get.snackbar("Error", "Gagal mengunggah data ke Firebase: $e");
      }
    } else {
      // Save to SharedPreferences
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> pendingPosts = prefs.getStringList('pendingPosts') ?? [];
        pendingPosts.add(jsonEncode(postData));
        await prefs.setStringList('pendingPosts', pendingPosts);

        Get.snackbar('Offline Mode', 'Data disimpan sementara');
        await Future.delayed(Duration(seconds: 4));
        Get.offNamed('home');
      } catch (e) {
        Get.snackbar("Error", "Gagal menyimpan data secara lokal: $e");
      }
    }
  }

  Future<void> syncOfflinePosts() async {
    if (isSyncing) return; // Cegah eksekusi paralel
    isSyncing = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> pendingPosts = prefs.getStringList('pendingPosts') ?? [];
    print('Test ini${pendingPosts}');

    if (pendingPosts.isNotEmpty) {
      for (String postDataString in pendingPosts) {
        try {
          Map<String, dynamic> postData = jsonDecode(postDataString);
          String imagePath = postData["imagePath"];
          String imageName = DateTime.now().millisecondsSinceEpoch.toString();
          var storageRef =
              FirebaseStorage.instance.ref().child('contentImg/$imageName.jpg');

          // Upload image
          var uploadTask = storageRef.putFile(File(imagePath));
          var downloadUrl = await (await uploadTask).ref.getDownloadURL();

          // Add post to Firebase
          postController.addPost(
            postData["username"],
            postData["title"],
            postData["tag"],
            postData["header"],
            postData["content"],
            postData["date"],
            downloadUrl,
          );
        } catch (e) {
          Get.snackbar("Error", "Gagal menyinkronkan data ke Firebase: $e");
          continue; // Skip this post and lanjut ke berikutnya
        }
      }
      // Hapus semua data offline setelah berhasil disinkronkan
      await prefs.remove('pendingPosts');
      Get.snackbar('Sync Complete', 'Semua data offline berhasil disinkronkan');
    }

    isSyncing = false; // Reset flag setelah selesai
  }

  void clearAll() {
    headerController.dispose();
    contentController.dispose();
    selectedVideo.value = null;
    selectedImage.value = null;
  }
}
