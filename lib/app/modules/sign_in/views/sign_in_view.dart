import 'package:blogg_apps/app/modules/widgets/custom_button.dart';
import 'package:blogg_apps/app/modules/widgets/custom_textField.dart';
import 'package:blogg_apps/app/modules/widgets/facebook_button.dart';
import 'package:blogg_apps/app/modules/widgets/google_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/controller/auth_controller.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  SignInView({super.key});

  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 20.5,
            vertical: height / 11,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Telegraf',
                ),
              ),
              const Text(
                'I am happy to see you again. You can continue where you left off by logging in',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Telegraf',
                ),
              ),
              const SizedBox(height: 35),
              CustomTextField(
                controller: signInController.emailController,
                keyboardType: TextInputType.text,
                hintText: 'Email',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 18),
                  child: Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: signInController.passwordController,
                keyboardType: TextInputType.text,
                hintText: 'Password',
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 18),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed('forgot-password');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'Telegraf',
                      color: Colors.black45,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () {
                  return CustomButton(
                    width: double.infinity,
                    onPressed: signInController.authController.isLoading.value
                        ? () {}
                        : () {
                            signInController.authController.loginUser(
                              signInController.emailController.text,
                              signInController.passwordController.text,
                            );
                            // Get.offAllNamed('home');
                          },
                    child: signInController.authController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Telegraf',
                              fontSize: 16, // Text size
                              fontWeight: FontWeight.bold, // Text weight
                            ),
                          ),
                  );
                },
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Or login in with',
                  style: TextStyle(
                    fontFamily: 'Telegraf',
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GoogleButton(),
                  FacebookButton(),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                        color: Colors.grey), // Style for normal text
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register',
                        style: const TextStyle(
                          fontFamily: 'Telegraf',
                          color: Colors.black, // Style for "Register"
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offNamed('sign-up');
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
