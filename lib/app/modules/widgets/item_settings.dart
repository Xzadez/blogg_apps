import 'package:flutter/material.dart';

class ItemSettings extends StatelessWidget {
  final String title;
  final String desc;
  final String assets;
  final VoidCallback? onPressed;
  const ItemSettings(
      {super.key,
      required this.title,
      required this.desc,
      required this.assets,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  assets,
                  color: Colors.black.withOpacity(0.4),
                  width: 25,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Telegraf',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    desc,
                    style: TextStyle(
                        fontFamily: 'Telegraf',
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.4)),
                  ),
                ],
              ),
            ],
          ),
          Image.asset(
            'assets/images/arrow-right-circle.png',
            width: 20,
          ),
        ],
      ),
    );
  }
}
