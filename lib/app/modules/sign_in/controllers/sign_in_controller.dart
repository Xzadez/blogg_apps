import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/controller/auth_controller.dart';

class SignInController extends GetxController {
  //TODO: Implement SignInController

  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
  }

  void increment() => count.value++;
}
