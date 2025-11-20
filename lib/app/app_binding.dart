import 'package:blogg_apps/app/data/controller/auth_controller.dart';
import 'package:blogg_apps/app/data/controller/post_controller.dart';
import 'package:get/get.dart';

import 'data/controller/connection.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionController>(() => ConnectionController(),
        fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<PostController>(() => PostController(), fenix: true);
  }
}
