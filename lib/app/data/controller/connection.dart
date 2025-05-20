import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  final RxBool isOnline = false.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((connectivityResults) {
      if (connectivityResults.isNotEmpty) {
        _updateConnectionStatus(connectivityResults.first);
      } else {
        print('Connectivity results list is empty');
      }
    });
  }

  // Monitor koneksi internet
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      isOnline.value = false;
      Get.snackbar("Warning", "Tidak ada koneksi");
    } else {
      isOnline.value = true;
    }
  }
}
