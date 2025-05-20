import 'dart:convert';
import 'dart:io';

import 'package:blogg_apps/app/data/controller/connection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/controller/post_controller.dart';

class EditController extends GetxController {
  final PostController postController = PostController();
  final ConnectionController connectionController =
      Get.put(ConnectionController());

  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  Future<void> openCameraImg() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> updateArticle(
      String articleId, String header, String content) async {
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
        FirebaseStorage.instance.ref().child('contentImg/$imageName.jpg');
    try {
      if (connectionController.isOnline.value) {
        var uploadTask = storageRef.putFile(File(selectedImage.value!.path));
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();
        postController.updatePost(articleId, header, content, downloadUrl);
        Get.snackbar('Success', 'Berhasil menambahkan gambar');
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String pendingData = jsonEncode({
          'articleId': articleId,
          'header': header,
          'content': content,
          'imagePath': selectedImage.value!.path,
        });

        await prefs.setString('pendingUpdate', pendingData);
        Get.snackbar(
            'Offline', 'Tidak ada koneksi internet, data disimpan sementara.');
        Get.offNamed('home');
      }
    } catch (e) {
      Get.snackbar("Error", "No image selected for upload.");
    }
  }

  Future<void> syncPendingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pendingData = prefs.getString('pendingUpdate');

    if (pendingData != null) {
      if (connectionController.isOnline.value) {
        var data = jsonDecode(pendingData);
        var storageRef = FirebaseStorage.instance
            .ref()
            .child('contentImg/${DateTime.now().millisecondsSinceEpoch}.jpg');

        try {
          // Upload gambar dari path yang tersimpan
          var uploadTask = storageRef.putFile(File(data['imagePath']));
          var downloadUrl = await (await uploadTask).ref.getDownloadURL();

          // Panggil updatePost controller dengan data pending
          postController.updatePost(
            data['articleId'],
            data['header'],
            data['content'],
            downloadUrl,
          );

          // Hapus data pending dari SharedPreferences
          await prefs.remove('pendingUpdate');
          Get.snackbar('Success', 'Data tersimpan ke server.');
        } catch (e) {
          Get.snackbar("Error", "Gagal menyinkronkan data: $e");
        }
      }
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
