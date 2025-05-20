import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/modals/articleAPI.dart';
import '../controllers/article_detail_controller.dart';

// ignore: must_be_immutable
class ArticleDetailWebView extends GetView<ArticleDetailController> {
  final Datum datum;
  const ArticleDetailWebView({
    super.key,
    required this.datum,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("WebView"),
        ),
        body: WebViewWidget(
          controller: controller.webViewController(datum.getWebUrl()),
        ));
  }
}
