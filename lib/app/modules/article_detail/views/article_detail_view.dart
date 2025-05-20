import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/modals/articleAPI.dart';
import '../controllers/article_detail_controller.dart';
import 'article_detail_web_view.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {
  final Datum datum;
  const ArticleDetailPage({Key? key, required this.datum}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: datum.imageId ?? datum.title ?? '',
              child: datum.imageId != null
                  ? Image.network(
                      datum.getImageUrl(),
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datum.shortDescription ?? "-",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    datum.title ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    'Date: ${datum.dateStart} - ${datum.dateEnd}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medium Of Display: ${datum.mediumDisplay}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Credit: ${datum.creditLine}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Author: ${datum.artistDisplay}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    'Origin: ${datum.placeOfOrigin}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Read more'),
                    onPressed: () {
                      if (datum != null) {
                        Get.to(() => ArticleDetailWebView(datum: datum));
                      } else {
                        // Handle null case, seperti menampilkan alert atau mengabaikan
                        print("Data is null, cannot navigate.");
                      }
                    },
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
