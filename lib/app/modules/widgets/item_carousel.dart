import 'package:flutter/material.dart';

class ItemCarousel extends StatelessWidget {
  final String tag;
  final String title;
  final String date;
  final String imgUrl;
  const ItemCarousel(
      {super.key,
      required this.tag,
      required this.title,
      required this.date,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            imgUrl != null
                ? Image.network(
                    imgUrl,
                    width: width,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    'https://p1.hiclipart.com/preview/658/470/455/krzp-dock-icons-v-1-2-empty-grey-empty-text-png-clipart.jpg',
                    width: 112,
                    height: 112,
                    fit: BoxFit.cover,
                  ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Color(0x08000000),
                            fontSize: 12,
                            fontFamily: 'Telegraf',
                          ),
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Color(0x08000000),
                          fontSize: 12,
                          fontFamily: 'Telegraf',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 120),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Color(0x08000000),
                      fontFamily: 'Telegraf',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
