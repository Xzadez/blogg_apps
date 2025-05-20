import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  LocationView({super.key});
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Your Location'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (locationController.isLoading.value) {
                return const Text("Loading location...");
              } else {
                return Text(
                  "Location: ${locationController.city}, ${locationController.country}",
                  style: const TextStyle(fontSize: 16),
                );
              }
            }),
            const SizedBox(height: 20),
            Obx(() {
              if (locationController.isLoading.value) {
                return const Text("Loading location...");
              } else {
                return Text(
                  "Latitude: ${locationController.latitude}, Longitude: ${locationController.longitude}",
                  style: const TextStyle(fontSize: 16),
                );
              }
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                locationController.openGoogleMaps();
              },
              child: const Text('Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
