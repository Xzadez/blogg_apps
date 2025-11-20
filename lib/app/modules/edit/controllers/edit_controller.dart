// edit_controller.dart (VERSI FINAL YANG BENAR)

import 'dart:io';
import 'package:blogg_apps/app/data/modals/article.dart';
import 'package:blogg_apps/app/modules/bookmarks/controllers/bookmarks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/controller/connection.dart';
import '../../../data/controller/post_controller.dart';

class EditController extends GetxController {
  final PostController postController = Get.find<PostController>();
  final ConnectionController connectionController =
      Get.find<ConnectionController>();

  final supabase = Supabase.instance.client;

  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  late Article article;
  late TextEditingController headerController;
  late TextEditingController contentController;

  @override
  void onInit() {
    super.onInit();
    article = Get.arguments;
    headerController = TextEditingController(text: article.header);
    contentController = TextEditingController(text: article.content);
  }

  @override
  void onClose() {
    clearAll();
    super.onClose();
  }

  void _refreshLists() {
    postController.fetchAllArticles();
    try {
      Get.find<BookmarksController>().fetchArticlesByAuthor();
    } catch (e) {}
  }

  Future<void> openCameraImg() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) selectedImage.value = image;
  }

  Future<void> updateArticle() async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      String imageUrlToUpdate = article.imgUrl;
      if (selectedImage.value != null) {
        final imageFile = File(selectedImage.value!.path);
        final imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        const bucketName = 'imgContent';

        await supabase.storage.from(bucketName).upload(
              imageName,
              imageFile,
              fileOptions:
                  const FileOptions(cacheControl: '3600', upsert: false),
            );

        imageUrlToUpdate =
            supabase.storage.from(bucketName).getPublicUrl(imageName);
      }

      await postController.updatePost(
        article.articleId,
        headerController.text,
        contentController.text,
        imageUrlToUpdate,
      );

      Get.back();
      _refreshLists();
      Get.snackbar('Success', 'Artikel berhasil diperbarui');
      Get.offNamed('home');
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Gagal memperbarui artikel: ${e.toString()}");
    }
  }

  void clearAll() {
    headerController.dispose();
    contentController.dispose();
    selectedImage.value = null;
  }
}
