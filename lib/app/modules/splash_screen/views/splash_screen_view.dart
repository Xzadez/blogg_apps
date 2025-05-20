import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  SplashScreenView({super.key});

  final splashController = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: splashController.opacityLevel.value,
            child: Image.asset(
              'assets/images/logo-no-background.png',
              width: 100,
            ),
          ),
        ),
      ),
    );
  }
}
