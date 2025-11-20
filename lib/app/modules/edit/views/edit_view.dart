import 'dart:io';

import 'package:blogg_apps/app/data/modals/article.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  EditView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          controller.article.title,
          style: const TextStyle(
            fontFamily: 'Telegraf',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              controller.updateArticle();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Text(
                "Save",
                style: TextStyle(
                  fontFamily: 'Telegraf',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Sesuaikan warna teks
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.headerController,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Telegraf',
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Header Here",
                  hintStyle: TextStyle(
                    fontFamily: 'Telegraf',
                  ),
                ),
                // controller: article.,
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  controller.article.tag,
                  style: const TextStyle(
                    fontFamily: 'Telegraf',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(onTap: () {
                controller.openCameraImg();
              }, child: Obx(() {
                if (controller.selectedImage.value != null) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.black.withOpacity(0.05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(controller.selectedImage.value!.path),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.black.withOpacity(0.05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        controller.article.imgUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              })),
              const SizedBox(height: 30),
              TextField(
                controller: controller.contentController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 20,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Telegraf',
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Get started writing here.....",
                  hintStyle: TextStyle(
                    fontFamily: 'Telegraf',
                  ),
                ),
                // controller: _addController.contentController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
