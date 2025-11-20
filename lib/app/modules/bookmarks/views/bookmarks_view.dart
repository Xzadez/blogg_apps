import 'package:blogg_apps/app/data/modals/article.dart';
import 'package:blogg_apps/app/modules/edit/bindings/edit_binding.dart';
import 'package:blogg_apps/app/modules/edit/views/edit_view.dart';
import 'package:blogg_apps/app/modules/widgets/custom_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/controller/connection.dart';
import '../../news/views/news_view.dart';
import '../controllers/bookmarks_controller.dart';

class BookmarksView extends GetView<BookmarksController> {
  BookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height / 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: const Text(
                'My Articles',
                style: TextStyle(
                  fontFamily: 'Telegraf',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF141E28),
                ),
              ),
            ),
            Obx(
              () {
                if (!Get.find<ConnectionController>().isOnline.value) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("No Data Available"),
                  ));
                } else {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.articles.isEmpty) {
                    return const Center(child: Text("No Data Available"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.articles.length,
                      itemBuilder: (context, index) {
                        final data = controller.articles[index];
                        return GestureDetector(
                          onTap: () async {
                            final fetchedArticle = await controller
                                .fetchArticleById(data.articleId);
                            if (fetchedArticle != null) {
                              Get.to(NewsView(fetchedArticle));
                            }
                          },
                          child: Dismissible(
                            confirmDismiss: (DismissDirection direction) async {
                              final fetchedArticle = await controller
                                  .fetchArticleById(data.articleId);
                              if (direction == DismissDirection.startToEnd) {
                                controller.deleteArticle(data.articleId);
                                Get.snackbar(
                                    'Berhasil', 'Article berhasil dihapus');
                                print(data.articleId);
                              } else {
                                if (fetchedArticle != null) {
                                  Get.to(
                                    () => EditView(),
                                    arguments: fetchedArticle,
                                    binding: EditBinding(),
                                  );
                                }
                              }
                              return false;
                            },
                            background: Container(
                              color: Colors.red,
                            ),
                            secondaryBackground: Container(
                              color: Colors.green,
                            ),
                            key: ValueKey<Article>(controller.articles[index]),
                            child: CustomItem(
                              title: data.title,
                              content: data.header,
                              urlImg: data.imgUrl,
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
