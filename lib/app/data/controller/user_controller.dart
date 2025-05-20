import 'package:blogg_apps/app/data/modals/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var username = ''.obs;

  Future<bool> checkUsernameExists(String username) async {
    final result = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<void> saveUserData(String uid, String email, String username) async {
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'username': username,
      'country': '',
    });
  }

  Future<Map<String, String?>> getUsername(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      String? username = userDoc['username'] as String?;
      String? email = userDoc['email'] as String?;
      return {
        'username': username,
        'email': email,
      };
    } catch (e) {
      print("Error: $e");
      return {
        'username': null,
        'email': null,
      };
    }
  }

  Future<User?> fetchArticleByEmail(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return User.fromDocument(
          querySnapshot.docs.first.data(),
        );
      }
    } catch (e) {
      print("Error fetching User by Email: $e");
    }
    return null;
  }
}
