import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../modals/articleAPI.dart';

class DioController extends GetxController {
  static const String _baseUrl = 'https://api.artic.edu/api/v1/artworks';

  RxList<Datum> articles = RxList<Datum>([]);
  RxBool isLoading = false.obs;

  final dio = Dio();

  @override
  void onInit() async {
    await fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final response = await dio.get(_baseUrl);

      if (response.statusCode == 200) {
        final jsonData = response.data;
        final articlesResult = ArticlesApi.fromJson(jsonData);
        articles.value = articlesResult.data!;
      } else {
        print("Request is failed with status ${response.statusCode}");
      }
    } catch (e) {
      print('An error occured: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
