import 'package:get/get.dart';

import '../controllers/notif_page_controller.dart';

class NotifPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifPageController>(
      () => NotifPageController(),
    );
  }
}
