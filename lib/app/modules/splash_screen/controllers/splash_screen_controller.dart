import 'package:get/get.dart';

import '../../../data/controller/auth_controller.dart';

class SplashScreenController extends GetxController {
  final AuthController _authController = Get.put(AuthController());

  var opacityLevel = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    print('test');
    _navigateToHome();
    _authController.checkLoginStatus();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 500));
    opacityLevel.value = 1.0;

    await Future.delayed(const Duration(seconds: 3));
    _authController.isLoggedIn.value
        ? Get.offAllNamed('/home')
        : Get.offAllNamed('/sign-in');
  }
}
