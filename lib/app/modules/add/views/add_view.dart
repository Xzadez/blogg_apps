import 'dart:io';

import 'package:blogg_apps/app/data/controller/connection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../data/controller/user_controller.dart';
import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  AddView({super.key});
  final AddController _addController = Get.put(AddController());
  final UserController userController = Get.put(UserController());

  final String title = Get.arguments['title'];
  final String tag = Get.arguments['tag'];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Telegraf',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (title != '') {
                _addController.savedArticles(title, tag);
                // FirebaseMessaging.instance.subscribeToTopic(title);
              } else {
                Get.snackbar('Error', 'Harus menambahkan title');
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Text(
                "Done",
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
                controller: _addController.headerController,
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
                  tag,
                  style: const TextStyle(
                    fontFamily: 'Telegraf',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _addController.openCameraImg();
                },
                child: Obx(() {
                  if (_addController.selectedVideo.value != null) {
                    print("Video: ${_addController.selectedVideo.value}");
                    return Container(
                      padding: const EdgeInsets.all(14),
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black.withOpacity(0.05),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: VideoPlayer(
                                  _addController.videoPlayerController!),
                            ),
                            Expanded(
                              child: VideoProgressIndicator(
                                _addController.videoPlayerController!,
                                allowScrubbing: true,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _addController.isVideoPlaying.isTrue
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                  onPressed: _addController.togglePlayPause,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (_addController.selectedImage.value != null) {
                    print("Image: ${_addController.selectedImage.value!.path}");
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
                          File(_addController.selectedImage.value!.path),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    print("No media selected");
                    return Container(
                      padding: const EdgeInsets.all(14),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black.withOpacity(0.05),
                      ),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: [10, 10],
                        color: Colors.black.withOpacity(0.3),
                        strokeWidth: 3,
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                            color: Colors.black.withOpacity(0.35),
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
              const SizedBox(height: 30),
              TextField(
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
                controller: _addController.contentController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
