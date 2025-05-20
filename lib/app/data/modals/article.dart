import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String articleId;
  final String author;
  final String content;
  final String date;
  final String header;
  final String imgUrl;
  final String tag;
  final String title;
  final String uid;

  Article({
    required this.articleId,
    required this.author,
    required this.content,
    required this.date,
    required this.header,
    required this.imgUrl,
    required this.tag,
    required this.title,
    required this.uid,
  });

  // Method to create an Article instance from a Firestore document
  factory Article.fromDocument(Map<String, dynamic> doc) {
    return Article(
      articleId: doc['article_id'],
      author: doc['author'],
      content: doc['content'],
      date: doc['date'],
      header: doc['header'],
      imgUrl: doc['imgUrl'],
      tag: doc['tag'],
      title: doc['title'],
      uid: doc['uid'],
    );
  }
}
