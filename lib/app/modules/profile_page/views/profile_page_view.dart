import 'package:blogg_apps/app/data/controller/user_controller.dart';
import 'package:blogg_apps/app/data/modals/user.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageView({super.key});
  final ProfilePageController profilePageController =
      Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if (profilePageController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final currentUser = profilePageController.user.value;
        if (currentUser == null) {
          return Center(child: Text('No user data found'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Image.asset(
                'assets/images/circle-user.png',
                width: 120,
              ),
              SizedBox(
                height: 60,
              ),
              _buildTextField(
                title: 'Username',
                value: currentUser.username,
                onTap: () {},
              ),
              _buildTextField(
                title: 'Email Address',
                value: currentUser.email,
                onTap: () {},
              ),
// ================================================ IMPLEMENTASI ================================================
              _buildTextField(
                title: 'Country',
                value: currentUser.country,
                onTap: () {
                  controller.displayTextTitleDialog(
                    false,
                    'country',
                    'Synconrsynchronization',
                    onPressed: () {
                      print(
                        profilePageController.country,
                      );
                      controller.updateUserData(
                        currentUser.email,
                        {'country': profilePageController.country.toString()},
                      );
                      Get.back();
                    },
                    controller: profilePageController.textEditingController,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField(
      {required String title,
      required String value,
      required VoidCallback onTap}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Telegraf',
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2, top: 5),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: 'Telegraf',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.mode_edit_outline_rounded),
                  onPressed: onTap,
                ),
              ],
            ),
            Divider(
              color: Colors.black87,
              thickness: 1,
              height: 12,
            ),
          ],
        ));
  }
}
