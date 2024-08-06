import 'package:datn/views/pages/home/widget/news_item.dart';
import 'package:flutter/material.dart';
import 'package:datn/data/data/list_news.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: const EdgeInsets.only(bottom: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 7),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff712BBC),
            Color(0xff715BBC),
            Color(0xffc9c9c9),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: ListNews.news.map((news) {
            return NewsItem(
              title: (news as Map)['title'],
              content: (news)['content'],
            );
          }).toList(),
        ),
      ),
    );
  }
}