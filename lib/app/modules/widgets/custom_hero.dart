import 'package:flutter/material.dart';

class CustomHero extends StatelessWidget {
  final String urlImg;
  final String categoryTitle;
  const CustomHero(
      {super.key, required this.urlImg, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Image.network(
              urlImg,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            Container(
              width: 120,
              height: 120,
              color: Colors.black.withOpacity(0.15),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  categoryTitle,
                  style: TextStyle(
                    fontFamily: 'Telegraf',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
