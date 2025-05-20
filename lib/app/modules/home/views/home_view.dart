import 'package:blogg_apps/app/modules/bookmarks/views/bookmarks_view.dart';
import 'package:blogg_apps/app/modules/home_page/views/home_page.dart';
import 'package:blogg_apps/app/modules/notif_page/views/notif_page_view.dart';
import 'package:blogg_apps/app/modules/search_page/views/search_page_view.dart';
import 'package:blogg_apps/app/modules/widgets/custom_bottomNavBar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../setting_page/views/setting_page_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final HomeController homeController = Get.put(HomeController());
  final List<Widget> pages = [
    HomePage(),
    BookmarksView(),
    SearchPageView(),
    SettingPageView(),
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Obx(() {
        return pages[homeController.selectedIndex.value];
      }),
      bottomNavigationBar: CustomBottomnavbar(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 20, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              )
            ],
          ),
          width: 50,
          height: 50,
          child: IconButton(
            onPressed: () {
              homeController.displayTextTitleDialog(
                true,
                'Create Title',
                'Buat judul semenarik mungkin',
                () {
                  homeController
                      .displayTextTagDialog(false, 'Add Tag', 'Tambah tag', () {
                    Get.toNamed('add', arguments: {
                      'title': titleController.text,
                      'tag': tagController.text
                    });
                  }, tagController);
                },
                titleController,
              );
            },
            icon: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
