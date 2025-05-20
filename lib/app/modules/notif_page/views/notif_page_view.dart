import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notif_page_controller.dart';

class NotifPageView extends GetView<NotifPageController> {
  NotifPageView({super.key});
  final NotifPageController _controller = Get.put(NotifPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _controller.pickAudio,
              child: const Text('Pilih dan Putar Audio'),
            ),
            Obx(() {
              return Slider(
                min: 0.0,
                max: controller.duration.value.inSeconds.toDouble(),
                value: controller.position.value.inSeconds.toDouble(),
                onChanged: (value) {
                  controller.seekAudio(Duration(seconds: value.toInt()));
                },
              );
            }),
            Obx(() {
              return Text(
                '${_formatDuration(controller.position.value)} / ${_formatDuration(controller.duration.value)}',
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.isPlaying.value
                        ? controller.pauseAudio
                        : controller.resumeAudio,
                    child:
                        Text(controller.isPlaying.value ? 'Pause' : 'Resume'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () =>
                        controller.playAudio(_controller.currentAudio.value),
                    child: const Text('Play'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: controller.stopAudio,
                    child: const Text('Stop'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

// Fungsi untuk memformat durasi menjadi menit:detik
  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
