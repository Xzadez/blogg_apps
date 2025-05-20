import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String country;

  User({
    required this.email,
    required this.username,
    required this.country,
  });

  // Method to create an User instance from a Firestore document
  factory User.fromDocument(Map<String, dynamic> doc) {
    try {
      return User(
        email: doc['email'] ?? '', // Default ke string kosong jika null
        username: doc['username'] ?? '',
        country: doc['country'] ?? '',
      );
    } catch (e) {
      throw Exception('Error parsing User: $e');
    }
  }

  /// Konversi instance User ke Map untuk penyimpanan ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'country': country,
    };
  }
}
