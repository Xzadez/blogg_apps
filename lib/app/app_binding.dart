import 'package:get/get.dart';

import 'data/controller/connection.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionController(), permanent: true);
  }
}
