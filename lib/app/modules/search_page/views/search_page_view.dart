import 'package:blogg_apps/app/modules/widgets/search_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/controller/dio_controller.dart';
import '../../../data/modals/article.dart';
import '../../news/views/news_view.dart';
import '../../widgets/card_article.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  final SearchPageController _controller = Get.put(SearchPageController());
  final DioController _dioController =
      Get.put(DioController()); // Tambahkan ini

  SearchPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 50,
          ),
          child: Column(
            children: [
              // Search Field with Listening Feature
              Obx(() {
                return _controller.isListening.value
                    ? SearchField(
                        onChanged: (value) {
                          _controller.searchArticles(value);
                        },
                        controller: _controller.searhController,
                        child: IconButton(
                          icon: const Icon(Icons.stop),
                          color: Colors.red,
                          onPressed: () {
                            _controller.stopListening();
                          },
                        ),
                      )
                    : SearchField(
                        onChanged: (value) {
                          _controller.searchArticles(value);
                        },
                        controller: _controller.searhController,
                        child: IconButton(
                          icon: const Icon(Icons.mic),
                          color: Colors.grey,
                          onPressed: () {
                            _controller.startListening();
                          },
                        ),
                      );
              }),

              const SizedBox(height: 20),

              // Display Search Results or API Articles
              Expanded(
                child: Obx(() {
                  if (_controller.isLoading.value ||
                      _dioController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Jika input pencarian kosong, tampilkan artikel dari API
                  if (_controller.searhController.text.isEmpty) {
                    if (_dioController.articles.isEmpty) {
                      return const Center(
                        child: Text('No articles available'),
                      );
                    }

                    return ListView.builder(
                      itemCount: _dioController.articles.length,
                      itemBuilder: (context, index) {
                        var article = _dioController.articles[index];
                        return CardArticle(datum: article);
                      },
                    );
                  }

                  // Jika ada hasil pencarian, tampilkan
                  if (_controller.searchResults.isEmpty) {
                    return const Center(
                      child: Text('No results found'),
                    );
                  }

                  return ListView.builder(
                    itemCount: _controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final articleData = _controller.searchResults[index]
                          .data() as Map<String, dynamic>;

                      // Konversi ke model Article
                      final article = Article.fromDocument(articleData);
                      return Card(
                        child: ListTile(
                          title: Text(article.title),
                          subtitle: Text('Author: ${article.author}'),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            // Navigasi ke NewsView dengan Article sebagai parameter
                            Get.to(NewsView(article));
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
