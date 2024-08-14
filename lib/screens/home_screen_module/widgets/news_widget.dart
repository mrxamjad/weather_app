// widgets/news_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        return ListTile(
          title: Text(article['title']),
          subtitle: Text(article['description'] ?? ''),
          onTap: () {
            // Open the full article (you can use url_launcher package)
          },
        );
      },
    );
  }
}
