import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class NotifPageController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var currentAudio = ''.obs;

  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();

    _audioPlayer.onDurationChanged.listen((d) {
      duration.value = d;
    });

    _audioPlayer.onPositionChanged.listen((p) {
      position.value = p;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        await playAudio(filePath);
      }
    }
  }

  Future<void> playAudio(String path) async {
    try {
      if (isPlaying.value) {
        await _audioPlayer.stop();
      }
      currentAudio.value = path;
      await _audioPlayer.play(DeviceFileSource(path));
      isPlaying.value = true;
    } catch (e) {
      isPlaying.value = false;
      Get.snackbar("Error", "Failed to play audio: $e");
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    isPlaying.value = false;
  }

  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    isPlaying.value = true;
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    position.value = Duration.zero;
  }

  void seekAudio(Duration newPosition) {
    _audioPlayer.seek(newPosition);
  }
}
