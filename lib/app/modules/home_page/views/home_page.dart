import 'package:blogg_apps/app/modules/news/views/news_view.dart';
import 'package:blogg_apps/app/modules/widgets/custom_item.dart';
import 'package:blogg_apps/app/modules/widgets/item-no-connection.dart';
import 'package:blogg_apps/app/modules/widgets/item2-connecntion.dart';
import 'package:blogg_apps/app/modules/widgets/item_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/controller/auth_controller.dart';
import '../../../data/controller/connection.dart';
import '../../add/controllers/add_controller.dart';
import '../controllers/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({super.key});

  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final AuthController authController = Get.find<AuthController>();
  final AddController _addController = Get.put(AddController());
  final ConnectionController connectionController =
      Get.put(ConnectionController());

  @override
  Widget build(BuildContext context) {
    final HomePageController _homePageController =
        Get.put(HomePageController());

    _homePageController.postController.fetchAllArticles();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() {
          // Periksa koneksi sekali di awal
          final bool isOnline = connectionController.isOnline.value;

          if (!isOnline) {
            // Jika tidak ada koneksi, tampilkan konten khusus offline
            return Column(
              children: [
                const SizedBox(height: 20),
                ItemNoConnection(),
                const SizedBox(height: 40),
                Item2Connection(),
              ],
            );
          }
          // Tampilkan konten untuk koneksi online
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: (width / 15),
                  top: (height / 15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hai, ${_prefs.getString('username')}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Telegraf',
                      ),
                    ),
                    const Text(
                      'Yuk, lihat konten menarik pilihan kami',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontFamily: 'Telegraf',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: _homePageController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : _homePageController.postController.dataList.isEmpty
                        ? const Center(child: Text("No Data Available"))
                        : CarouselSlider(
                            items: _homePageController.postController.dataList
                                .map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final fetchedArticle =
                                          await _homePageController
                                              .postController
                                              .fetchArticleById(item.articleId);
                                      if (fetchedArticle != null) {
                                        Get.to(NewsView(fetchedArticle));
                                      }
                                    },
                                    child: ItemCarousel(
                                      tag: item.tag,
                                      title: item.title,
                                      date: item.date,
                                      imgUrl: item.imgUrl,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              aspectRatio: 1.2,
                              enableInfiniteScroll: false,
                              initialPage: 0,
                              autoPlay: false,
                              viewportFraction: 0.90,
                            ),
                          ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(
                  left: (width / 15),
                  right: (width / 15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest News',
                      style: TextStyle(
                        fontFamily: 'Telegraf',
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Image.asset(
                      'assets/images/arrow-right-circle.png',
                      width: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: _homePageController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : _homePageController.postController.dataList.isEmpty
                        ? const Center(child: Text("No Data Available"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _homePageController
                                .postController.dataList.length,
                            itemBuilder: (context, index) {
                              final data = _homePageController
                                  .postController.dataList[index];
                              return GestureDetector(
                                onTap: () async {
                                  final fetchedArticle =
                                      await _homePageController.postController
                                          .fetchArticleById(data.articleId);
                                  if (fetchedArticle != null) {
                                    Get.to(NewsView(fetchedArticle));
                                  }
                                },
                                child: CustomItem(
                                  title: data.title,
                                  content: data.header,
                                  urlImg: data.imgUrl,
                                ),
                              );
                            },
                          ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
