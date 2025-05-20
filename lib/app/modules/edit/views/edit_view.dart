import 'dart:io';

import 'package:blogg_apps/app/data/modals/article.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  EditView(this.article, {super.key});
  final EditController _editController = EditController();

  final Article article;

  @override
  Widget build(BuildContext context) {
    final headerController = TextEditingController(text: article.header);
    final contentController = TextEditingController(text: article.content);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          article.title,
          style: const TextStyle(
            fontFamily: 'Telegraf',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              _editController.updateArticle(
                article.articleId,
                headerController.text,
                contentController.text,
              );
              // FirebaseMessaging.instance.subscribeToTopic(title);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Text(
                "Edit",
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
                controller: headerController,
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
                  article.tag,
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
                _editController.openCameraImg();
              }, child: Obx(() {
                if (_editController.selectedImage.value != null) {
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
                        File(_editController.selectedImage.value!.path),
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
                        article.imgUrl,
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
                controller: contentController,
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
