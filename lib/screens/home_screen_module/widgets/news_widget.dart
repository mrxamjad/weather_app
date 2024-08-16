// widgets/news_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/constant/directory.dart';
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
        return GestureDetector(
          onTap: () {
            launchURL(article["link"]);
          },
          child: SizedBox(
            height: 500,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: article['image_url'] != null
                                ? NetworkImage(
                                    article['image_url'],
                                  )
                                : const AssetImage(Dir.noImage)
                                    as ImageProvider)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 10, top: 5),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: article['source_icon'] != null
                                            ? NetworkImage(
                                                article['source_icon'],
                                              )
                                            : const AssetImage(Dir.noImage)
                                                as ImageProvider)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(article["source_name"])
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            article['title'],
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            article['description'] ?? '',
                            maxLines: 8,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Clr.greyAEAEAE),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              article["source_url"],
                              style: TextStyle(
                                  fontSize: 10, color: Clr.greyAEAEAE),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
