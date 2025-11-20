import 'package:blogg_apps/app/modules/bookmarks/controllers/bookmarks_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BookmarksController>(
      () => BookmarksController(),
    );
  }
}
