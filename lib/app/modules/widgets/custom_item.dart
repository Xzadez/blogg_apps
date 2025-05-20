import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String? urlImg;
  final String? title;
  final String? content;
  const CustomItem(
      {super.key, this.urlImg = '', this.title = '', this.content = ''});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: width / 15,
        right: width / 15,
      ),
      child: SizedBox(
        height: 130,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: urlImg != null
                  ? Image.network(
                      urlImg!,
                      width: 112,
                      height: 112,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      'https://p1.hiclipart.com/preview/658/470/455/krzp-dock-icons-v-1-2-empty-grey-empty-text-png-clipart.jpg',
                      width: 112,
                      height: 112,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 1.85,
                  child: Text(
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    title!,
                    style: const TextStyle(
                      fontFamily: 'Telegraf',
                      fontWeight: FontWeight.bold,
                      color: Color(0x48141E28),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 1.85,
                  child: Text(
                    content!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontFamily: 'Telegraf',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
