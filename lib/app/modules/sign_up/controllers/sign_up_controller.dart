import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/controller/auth_controller.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

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
    emailController.clear();
    passwordController.clear();
    repeatPassController.clear();
    usernameController.clear();
  }

  void increment() => count.value++;
}
