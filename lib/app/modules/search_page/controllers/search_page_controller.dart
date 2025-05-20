import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../data/controller/post_controller.dart';

class SearchPageController extends GetxController {
  final stt.SpeechToText _speech = stt.SpeechToText();
  var isListening = false.obs;

  var searchResults = [].obs; // Observable untuk menyimpan hasil pencarian
  var isLoading = false.obs;
  final TextEditingController searhController = TextEditingController();
  final PostController postController = Get.put(PostController());

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searhController.dispose();
  }

  void _initSpeech() async {
    try {
      await _speech.initialize();
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  void startListening() async {
    await checkMicrophonePermission();
    if (await Permission.microphone.isGranted) {
      isListening.value = true;
      await _speech.listen(onResult: (result) {
        searhController.text = result.recognizedWords;
      });
    } else {
      print("Izin mikrofon ditolak.");
    }
  }

  void stopListening() async {
    isListening.value = false;
    await _speech.stop();
  }

  Future<void> searchArticles(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('articles')
          .where('header', isGreaterThanOrEqualTo: query)
          .where('header', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final authorSnapshot = await FirebaseFirestore.instance
          .collection('articles')
          .where('author', isGreaterThanOrEqualTo: query)
          .where('author', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final contentSnapshot = await FirebaseFirestore.instance
          .collection('articles')
          .where('content', isGreaterThanOrEqualTo: query)
          .where('content', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final titleSnapshot = await FirebaseFirestore.instance
          .collection('articles')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Gabungkan semua hasil pencarian
      final combinedResults = [
        ...snapshot.docs,
        ...authorSnapshot.docs,
        ...contentSnapshot.docs,
        ...titleSnapshot.docs,
      ];

      // Hilangkan duplikat berdasarkan ID dokumen
      final uniqueResults = combinedResults.toSet().toList();

      searchResults.value = uniqueResults;
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat mencari: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
