import 'package:blogg_apps/app/modules/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowOptions extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback onPressedImg;
  final VoidCallback onPressedVid;
  const ShowOptions({
    super.key,
    required this.title,
    required this.desc,
    required this.onPressedImg,
    required this.onPressedVid,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        width: width / 1.145,
        height: height / 3,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Telegraf',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF141E28),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                desc,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Telegraf',
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                  color: Color(0xFF141E28),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: onPressedImg,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(185, 0, 211, 28),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20), // Padding
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: onPressedVid,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(185, 0, 211, 28),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                      ),
                      child: const Icon(
                        Icons.video_collection_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
