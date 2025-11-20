import 'package:blogg_apps/app/data/controller/post_controller.dart';
import 'package:blogg_apps/app/data/modals/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  var articles = <Article>[].obs;
  final PostController _postController = Get.put(PostController());
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticlesByAuthor();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Article?> fetchArticleById(String author) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('articles')
          .where('article_id', isEqualTo: author)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs.first.data());
        return Article.fromDocument(
          querySnapshot.docs.first.data(),
        );
      }
    } catch (e) {
      print("Error fetching article by ID: $e");
    }
    return null;
  }

  Future<void> fetchArticlesByAuthor() async {
    final username = _prefs.getString('username');
    if (username != null && username.isNotEmpty) {
      isLoading.value = true;
      articles.value = await _postController.getArticlesByAuthor(username);
      isLoading.value = false;
    }
  }

  Future<void> deleteArticle(String documentId) async {
    _postController.deleteDocumentByArticleId(documentId);
    articles.removeWhere((article) => article.articleId == documentId);
  }
}
