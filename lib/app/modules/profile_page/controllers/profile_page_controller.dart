import 'package:blogg_apps/app/modules/widgets/custom_showDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/modals/user.dart';

class ProfilePageController extends GetxController {
  final Rx<User?> user = Rx<User?>(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxBool isLoading = false.obs;
  late String email;
  Position? currentPosition;
  var country = ''.obs;
  var city = ''.obs;
  final TextEditingController textEditingController = TextEditingController();

  Future<void> displayTextTitleDialog(
    bool textArea,
    String title,
    String desc, {
    required VoidCallback onPressed,
    required TextEditingController controller,
  }) async {
    return Get.dialog(CustomShowdialog(
      action: 'Save',
      textArea: textArea,
      title: title,
      desc: desc,
      onPressed: onPressed,
      controller: controller,
      enable: false,
    ));
  }

  final count = 0.obs;
  @override
  void onInit() {
    _loadEmailAndFetchData();

    // Deklarasi saat page dibuka
    _getLocation();
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

// ================================================ MODUL 5 GET LOCATION ================================================

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          isLoading.value = false;
          return;
        }
      }

      currentPosition = await Geolocator.getCurrentPosition();
      await _getAddressFromLatLng();
    } catch (e) {
      print(e);
    }
  }

// ================================================ MODUL 5 GET COUNTRY & CITY ================================================

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude,
        currentPosition!.longitude,
      );

      Placemark place = placemarks[0];
      country.value = "${place.country}";
      city.value = "${place.locality}";
      textEditingController.text = "${place.country}, ${place.locality}";
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadEmailAndFetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email') ?? '';

      if (email.isNotEmpty) {
        await fetchUserData();
      } else {
        print("Email tidak ditemukan di SharedPreferences");
      }
    } catch (e) {
      print("Error saat mengambil email: $e");
    }
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        user.value = User.fromDocument(data);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserData(
      String email, Map<String, dynamic> updatedData) async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await _firestore.collection('users').doc(doc.id).update(updatedData);
        }
        print('Data berhasil diperbarui');
        await fetchUserData();
      } else {
        print('Dokumen dengan email tersebut tidak ditemukan');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
