import 'package:blogg_apps/app/modules/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomShowdialog extends StatelessWidget {
  final bool textArea;
  final bool enable;
  final String title;
  final String desc;
  final String action;
  final VoidCallback onPressed;
  final TextEditingController controller;
  CustomShowdialog({
    super.key,
    this.textArea = false,
    required this.title,
    required this.desc,
    required this.onPressed,
    required this.controller,
    required this.enable,
    required this.action,
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
        height: textArea ? (height / 2) : (height / 2.5),
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
              const SizedBox(height: 25),
              Material(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0x15141E28),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: textArea
                      ? TextField(
                          textInputAction: TextInputAction.done,
                          controller: controller,
                          maxLength: 100,
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                            fontFamily: 'Telegraf',
                            fontSize: 18,
                            color: Color(0xFF141E28),
                          ),
                          maxLines: 3, //or null
                          decoration: const InputDecoration.collapsed(
                            hintText: "Enter your title here",
                            hintStyle: TextStyle(
                              fontFamily: 'Telegraf',
                            ),
                          ),
                        )
                      : TextField(
                          enabled: enable,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.sentences,
                          controller: controller,
                          style: const TextStyle(
                            fontFamily: 'Telegraf',
                            fontSize: 16,
                            color: Color(0xFF141E28),
                          ),
                          maxLines: 1,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Tags..",
                            hintStyle: TextStyle(
                              fontFamily: 'Telegraf',
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 38),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  child: Text(
                    action,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Telegraf',
                      fontSize: 16, // Text size
                      fontWeight: FontWeight.bold, // Text weight
                    ),
                  ),
                  onPressed: onPressed,
                  width: width / 2.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
