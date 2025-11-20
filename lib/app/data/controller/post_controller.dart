import 'dart:math';

import 'package:blogg_apps/app/modules/bookmarks/controllers/bookmarks_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/article.dart';

class PostController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  late final FirebaseFirestore firestore;
  var dataList = <Article>[].obs;
  RxBool isLoading = false.obs;

  PostController({FirebaseFirestore? firestoreInstance}) {
    firestore = firestoreInstance ?? FirebaseFirestore.instance;
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllArticles();
  }

  Future<void> addPost(String author, String title, String tag, String header,
      String content, String date, String imgUrl) async {
    String randomid;
    bool isExist = false;
    do {
      randomid = ('ART${generateRandomId(5)}');
      DocumentSnapshot doc =
          await firestore.collection('articles').doc(randomid).get();
      if (!doc.exists) {
        isExist = true;
      }
    } while (!isExist);

    await firestore.collection('articles').add(<String, dynamic>{
      'uid': _prefs.get('user_token'),
      'article_id': randomid,
      'author': author,
      'title': title,
      'tag': tag,
      'header': header,
      'content': content,
      'date': date,
      'imgUrl': imgUrl,
    });
  }

  Future<void> updatePost(
      String articleId, String header, String content, String imgUrl) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('articles')
        .where('article_id', isEqualTo: articleId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      await firestore.collection('articles').doc(docId).update({
        'header': header,
        'content': content,
        'imgUrl': imgUrl,
      });
    } else {
      throw Exception('Dokumen dengan article_id: $articleId tidak ditemukan');
    }
  }

  String generateRandomId(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }

  Future<void> fetchAllArticles() async {
    try {
      isLoading.value = true;
      final querySnapshot = await firestore.collection('articles').get();
      dataList.value = querySnapshot.docs
          .map((doc) => Article.fromDocument(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching articles: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Article?> fetchArticleById(String articleId) async {
    try {
      final querySnapshot = await firestore
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
    QuerySnapshot snapshot = await firestore
        .collection('articles')
        .where('author',
            isEqualTo: authorName.trim().toLowerCase()) // Query yang lebih aman
        .get();
    return snapshot.docs
        .map((doc) => Article.fromDocument(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteDocumentByArticleId(String articleId) async {
    QuerySnapshot snapshot = await firestore
        .collection('articles')
        .where('article_id', isEqualTo: articleId)
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    // Panggil refresh setelah hapus
    fetchAllArticles();
    Get.find<BookmarksController>().fetchArticlesByAuthor();
  }
}
