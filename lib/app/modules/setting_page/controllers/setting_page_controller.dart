import 'package:blogg_apps/app/data/controller/user_controller.dart';
import 'package:get/get.dart';

class SettingPageController extends GetxController {
  final UserController userController = Get.put(UserController());

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

  void increment() => count.value++;
}
