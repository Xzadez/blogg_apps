import 'package:blogg_apps/app/data/controller/auth_controller.dart';
import 'package:blogg_apps/app/modules/profile_page/views/profile_page_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/setting_page_controller.dart';

class SettingPageView extends GetView<SettingPageController> {
  SettingPageView({super.key});
  final SettingPageController _settingPageController =
      Get.put(SettingPageController());

  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Telegraf',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(
                    img: 'assets/images/person-outline.png',
                    title: 'Profile settings',
                    subtitle: 'Settings regarding your profile',
                    icon: Icons.arrow_circle_right_outlined,
                    onTap: () async {
                      Get.to(ProfilePageView());
                    },
                  ),
                  _buildListTile(
                    img: 'assets/images/notifications_icon.png',
                    title: 'Notifications',
                    subtitle: 'When would you like to be notified',
                    icon: Icons.arrow_circle_right_outlined,
                    onTap: () {
                      Get.toNamed('notif-page');
                    },
                  ),
                  _buildListTile(
                    img: 'assets/images/map.png',
                    title: 'Location',
                    subtitle: 'Where is your position now?',
                    icon: Icons.arrow_circle_right_outlined,
                    onTap: () async {
                      Get.toNamed('/location');
                    },
                  ),
                  _buildListTile(
                    img: 'assets/images/exit-icon.png',
                    title: 'Logout',
                    subtitle: 'Logout your account',
                    icon: Icons.arrow_circle_right_outlined,
                    onTap: () {
                      _authController.logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String img,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(22),
                    color: Colors.grey.withOpacity(0.3),
                    child: Image.asset(
                      img,
                      width: 25,
                      height: 25,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Telegraf',
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Telegraf',
                        fontSize: 12,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
