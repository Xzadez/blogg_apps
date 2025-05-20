import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/article.dart';

class PostController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var dataList = <Article>[].obs;

  RxBool isLoading = false.obs;

  Future<void> addPost(
    String author,
    String title,
    String tag,
    String header,
    String content,
    String date,
    String imgUrl,
  ) async {
    String randomid;
    bool isExist = false;
    try {
      isLoading.value = true;
      do {
        randomid = ('ART${generateRandomId(5)}');
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('articles')
            .doc(randomid)
            .get();

        if (!doc.exists) {
          isExist = true;
        }
      } while (!isExist);

      CollectionReference article = firestore.collection('articles');
      DocumentReference result = await article.add(
        <String, dynamic>{
          'uid': _prefs.get('user_token'),
          'article_id': randomid,
          'author': author,
          'title': title,
          'tag': tag,
          'header': header,
          'content': content,
          'date': date,
          'imgUrl': imgUrl,
        },
      );

      if (result.id != null) {
        Get.offNamed('home');
      }
      Get.snackbar('Success', 'Posting successful',
          backgroundColor: Colors.green);
      Get.offNamed('home');
    } catch (error) {
      Get.snackbar('Error', 'Posting failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePost(
      String articleId, String header, String content, String imgUrl) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('articles')
          .where('article_id', isEqualTo: articleId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('articles')
            .doc(docId)
            .update({
          'header': header,
          'content': content,
          'imgUrl': imgUrl,
        });
        Get.snackbar('Success', 'Post updated successfully',
            backgroundColor: Colors.green);
        Get.offNamed('home');
      } else {
        Get.snackbar('Error', 'No document found with article_id: $articleId',
            backgroundColor: Colors.red);
        Get.offNamed('home');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update post: $e');
    }
  }

  String generateRandomId(int length) {
    final random = Random();
    final articleId = List.generate(length, (_) => random.nextInt(10)).join();
    return articleId;
  }

  Future<void> fetchAllArticles() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('articles').get();
      dataList.value = querySnapshot.docs
          .map((doc) => Article.fromDocument(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching articles: $e");
    }
  }

  Future<Article?> fetchArticleById(String articleId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('articles')
          .where('article_id', isEqualTo: articleId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return Article.fromDocument(
          querySnapshot.docs.first.data(),
        );
      }
    } catch (e) {
      print("Error fetching article by ID: $e");
    }
    return null;
  }

  Future<List<Article>> getArticlesByAuthor(String authorName) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('articles')
        .where('author', isEqualTo: authorName) // Filtering by author
        .get();

    return snapshot.docs
        .map((doc) => Article.fromDocument(doc.data() as Map<String, dynamic>))
        .toList();
  }

  void deleteDocumentByArticleId(String articleId) async {
    try {
      // Reference to the Firestore collection
      CollectionReference articles =
          FirebaseFirestore.instance.collection('articles');

      // Query to find the document with the specific article_id
      QuerySnapshot snapshot =
          await articles.where('article_id', isEqualTo: articleId).get();

      // Loop through the documents and delete them
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
        print("Document with article_id: $articleId deleted successfully");
      }
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
}
