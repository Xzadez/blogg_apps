import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
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
            vertical: height / 10,
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
              const SizedBox(height: 40),
              const CustomTextField(
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email Address',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 18),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                width: double.infinity,
                onPressed: () {
                  print('Check your email');
                },
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Telegraf',
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                ),
              ),
              const SizedBox(height: 300),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Remember the password? ",
                    style:
                        TextStyle(color: Colors.grey), // Style for normal text
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Try again',
                        style: TextStyle(
                          fontFamily: 'Telegraf',
                          color: Colors.black, // Style for "Register"
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAllNamed('sign-in');
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
