// widgets/news_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/methods/url_launcher.dart';
import 'package:weatther_app/providers/news_provider.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    if (newsProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsProvider.news.length,
      itemBuilder: (context, index) {
        final article = newsProvider.news[index];
        return Column(
          children: [
            if (article['image_url'] != null)
              Image.network(
                article['image_url'],
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
            ListTile(
              title: Text(article['title']),
              subtitle: Text(article['description'] ?? ''),
              onTap: () {
                launchURL(article['link']);
              },
            ),
          ],
        );
      },
    );
  }
}
