import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  var city = ''.obs;
  var country = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = true.obs;
  final Rxn<Position> _currentPosition = Rxn<Position>();

  // Getter untuk mengakses nilai
  Position? get currentPosition => _currentPosition.value;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getLocation() async {
    try {
      // Meminta izin lokasi
      isLoading.value = true;
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            "Location permission is permanently denied. Please enable it in settings.");
      }

      // Mendapatkan koordinat lokasi pengguna
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      _currentPosition.value = position;
      // Mengonversi koordinat menjadi nama lokasi
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        city.value = placemarks[0].locality ?? 'Unknown City';
        country.value = placemarks[0].country ?? 'Unknown Country';
        latitude.value = position.latitude ?? 0.0;
        longitude.value = position.longitude ?? 0.0;
      }
    } catch (e) {
      print("Error getting location: $e");
      Get.snackbar(
        "Location Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false; // Proses selesai
    }
  }

  void openGoogleMaps() {
    print(_currentPosition);
    if (_currentPosition != null) {
      final url =
          'https://www.google.com/maps?q=${currentPosition!.latitude},${currentPosition!.longitude}';
      _launchURL(url);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
