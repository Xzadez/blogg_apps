import 'package:blogg_apps/app/data/modals/article.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  final Article article;
  NewsView(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height / 2,
                    width: width,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(28),
                          bottomRight: Radius.circular(28),
                        ),
                        child: Image.network(
                          article.imgUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: GestureDetector(
                      onTap: () => Get.offNamed('home'),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black38,
                        ),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/creator-icon.png',
                      width: 45,
                    ),
                    SizedBox(width: 14),
                    Text(
                      article.author,
                      style: TextStyle(
                        fontFamily: 'Telegraf',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  'Tag: ${article.tag}',
                  style: TextStyle(
                    fontFamily: 'Telegraf',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  '${article.header}',
                  style: TextStyle(
                    fontFamily: 'Telegraf',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  'Tanggal diposting : ${article.date}',
                  style: TextStyle(
                    fontFamily: 'Telegraf',
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Text(
                  article.content,
                  style: TextStyle(
                    fontFamily: 'Telegraf',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
