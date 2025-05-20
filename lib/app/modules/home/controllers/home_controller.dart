import 'package:blogg_apps/app/modules/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_showDialog.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

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

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> displayTextTitleDialog(bool textArea, String title, String desc,
      VoidCallback onPressed, TextEditingController controller) async {
    return Get.dialog(CustomShowdialog(
      textArea: textArea,
      title: title,
      desc: desc,
      onPressed: onPressed,
      controller: controller,
      enable: true,
      action: 'Next',
    ));
  }

  Future<void> displayTextTagDialog(bool textArea, String title, String desc,
      VoidCallback onPressed, TextEditingController controller) async {
    print(textArea);

    return Get.dialog(CustomShowdialog(
      textArea: textArea,
      title: title,
      desc: desc,
      onPressed: onPressed,
      controller: controller,
      enable: true,
      action: 'Next',
    ));
  }
}
