import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/modals/articleAPI.dart';
import '../../routes/app_pages.dart';

class CardArticle extends StatelessWidget {
  final Datum datum;
  const CardArticle({Key? key, required this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: datum.imageId ?? datum.title ?? '',
          child: SizedBox(
            width: 100,
            height: 100,
            child: datum.getImageUrl() != ''
                ? Image.network(
                    datum.getImageUrl()!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Text(
                        'No Image',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
        ),
        title: Text(
          datum.title ?? '',
        ),
        subtitle: Text(datum.artistDisplay ?? 'Unknown'),
        onTap: () {
          Get.toNamed(Routes.ARTICLE_DETAILS, arguments: datum);
        },
      ),
    );
  }
}
