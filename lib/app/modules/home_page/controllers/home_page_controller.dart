import 'package:blogg_apps/app/data/controller/post_controller.dart';
import 'package:blogg_apps/app/modules/add/controllers/add_controller.dart';
import 'package:get/get.dart';

import '../../edit/controllers/edit_controller.dart';

class HomePageController extends GetxController {
  final PostController postController = Get.put(PostController());
  final EditController _editController = Get.put(EditController());
  final AddController _addController = Get.put(AddController());
  var isLoading = true.obs;
  var imageUrls = <String>[].obs;

  @override
  void onInit() {
    _editController.syncPendingData();

    Future.delayed(Duration(seconds: 5), () {
      // Setelah delay, set loading ke false dan load data
      isLoading.value = false;
      super.onInit();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchImages() {
    // Menambahkan URL gambar secara manual
    imageUrls.value = [
      'https://images.unsplash.com/photo-1485463611174-f302f6a5c1c9?q=80&w=1176&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
  }
}
