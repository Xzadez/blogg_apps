import 'package:flutter/material.dart';

class Item2Connection extends StatelessWidget {
  const Item2Connection({super.key});

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
              child: Image.asset(
                'assets/images/no-connection.png',
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
                    'Tidak ada internet',
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
                    'Tidak ada internet',
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
