import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_controller.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserController _userController = Get.put(UserController());
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  RxString username = ''.obs;
  RxString email = ''.obs;
  RxString country = ''.obs;

  Future<void> registerUser(
      String email, String password, String username) async {
    try {
      isLoading.value = true;

      if (await _userController.checkUsernameExists(username)) {
        Get.snackbar('Error', 'Username sudah digunakan',
            backgroundColor: Colors.red);
        isLoading.value = false;
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _userController.saveUserData(
          userCredential.user!.uid, email, username);

      Get.snackbar('Berhasil', 'Registrasi berhasil',
          backgroundColor: Colors.green);
      Get.offNamed('sign-in');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'Password minimal 6 karakter',
            backgroundColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Email sudah terdaftar',
            backgroundColor: Colors.red);
      } else {
        Get.snackbar('Error', 'Registrasi Gagal: ${e.message}',
            backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Terjadi kesalahan, silakan coba lagi',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _prefs.containsKey('user_token');
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      _prefs.setString('user_token', _auth.currentUser!.uid);
      isLoggedIn.value = true;

      await loadUsername(uid);

      await Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      Get.offNamed('home');
    } catch (error) {
      Get.snackbar('Error', 'Email atau Password Salah',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUsername(String uid) async {
    final storedUsername = await _userController.getUsername(uid);
    if (storedUsername != null) {
      username.value = storedUsername['username'] ?? 'Unknown';
      email.value = storedUsername['email'] ?? 'Unknown';
      _prefs.setString('username', username.value);
      _prefs.setString('email', email.value);
    } else {
      print("Username not found for uid: $uid");
    }
  }

  void logout() {
    _prefs.remove('user_token');
    isLoggedIn.value = false;
    username.value = '';
    _auth.signOut();
    Get.offAllNamed('/sign-in');
  }
}
