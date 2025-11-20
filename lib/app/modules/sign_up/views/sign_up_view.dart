import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/controller/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({super.key});

  final SignUpController signUpController = Get.put(SignUpController());
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
                'Welcome to Blogg 👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Telegraf',
                ),
              ),
              const Text(
                'Hello, I guess you are new around here. You can start using the application after sign up.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Telegraf',
                ),
              ),
              const SizedBox(height: 35),
              CustomTextField(
                controller: signUpController.usernameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'Username',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 24, right: 18),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: signUpController.emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hintText: 'Email',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 24, right: 18),
                  child: const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: signUpController.passwordController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'Password',
                isPassword: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 24, right: 18),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                keyboardType: TextInputType.name,
                controller: signUpController.repeatPassController,
                textInputAction: TextInputAction.next,
                hintText: 'Repeat Password',
                isPassword: true,
                validator: (val) {
                  if (val!.isEmpty) return 'Empty';
                  if (val != signUpController.repeatPassController.text)
                    return 'Not Match';
                  return null;
                },
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 24, right: 18),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () {
                  return CustomButton(
                    width: double.infinity,
                    onPressed: signUpController.authController.isLoading.value
                        ? () {}
                        : () {
                            final password =
                                signUpController.passwordController.text;
                            final repeatPassword =
                                signUpController.repeatPassController.text;

                            if (password != repeatPassword) {
                              Get.snackbar(
                                'Error',
                                'Password tidak cocok, silakan periksa kembali.',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }
                            signUpController.authController.registerUser(
                              signUpController.emailController.text,
                              signUpController.passwordController.text,
                              signUpController.usernameController.text,
                            );
                          },
                    child: signUpController.authController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Telegraf',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                        color: Colors.grey), // Style for normal text
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(
                          fontFamily: 'Telegraf',
                          color: Colors.black, // Style for "Register"
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offNamed('sign-in');
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
