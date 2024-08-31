import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/constant/directory.dart';
import 'package:weatther_app/methods/date_formate.dart';
import 'package:weatther_app/methods/url_launcher.dart';
import 'package:weatther_app/providers/news_provider.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/providers/weather_provider.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> newsCatogery = [
      "top",
      'business',
      'entertainment',
      'health',
      'science',
      'sports',
      'technology',
      'education'
    ];

    List<String> selectedCategories = [];

    final newsProvider = Provider.of<NewsProvider>(context);
    final settings = Provider.of<SettingsProvider>(context);
    selectedCategories = settings.selectedCategories.toList();

    return SizedBox(
      height: 572,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: "Breaking ",
                    style: TextStyle(fontSize: 24, color: Clr.black),
                    children: const [
                      TextSpan(
                        text: "news",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer<SettingsProvider>(
                  builder: (context, settings, child) {
                return Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    for (var category in newsCatogery)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            final mood = Provider.of<WeatherProvider>(context,
                                    listen: false)
                                .weatherData['weather'][0]['main'];
                            // newsProvider.fetchNews(category);
                            if (settings.selectedCategories
                                .contains(category)) {
                              selectedCategories.remove(category);
                              // newsProvider.fetchNews(
                              //     weather: mood,
                              //     country: "in",
                              //     category: selectedCategories.join(','));
                            } else {
                              selectedCategories.clear();

                              selectedCategories.add(category);
                            }

                            newsProvider.fetchNews(
                                category: selectedCategories.join(','),
                                weather: mood);
                            settings.updateCategories(selectedCategories);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 26, vertical: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: settings.selectedCategories
                                            .contains(category)
                                        ? Clr.black
                                        : Clr.white.withOpacity(0.75)),
                                color: Clr.white.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(24)),
                            child: Text(category.capitalize()),
                          ),
                        ),
                      )
                  ],
                );
              }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: !newsProvider.isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: newsProvider.news.length,
                    itemBuilder: (context, index) {
                      final article = newsProvider.news[index];

                      return GestureDetector(
                        onTap: () {
                          launchURL(article["link"]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 500,
                            width: 300,
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
                                                    as ImageProvider,
                                            onError: (exception, stackTrace) {
                                              // Handle image loading error here
                                              const AssetImage(Dir.noImage)
                                                  as ImageProvider;
                                            }),
                                      )),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 10,
                                          top: 5),
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
                                                        image: article[
                                                                    'source_icon'] !=
                                                                null
                                                            ? NetworkImage(
                                                                article[
                                                                    'source_icon'],
                                                              )
                                                            : const AssetImage(
                                                                    Dir.noImage)
                                                                as ImageProvider)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                article["source_name"],
                                                maxLines: 1,
                                              )),
                                              Text(
                                                  formatDate(
                                                      article['pubDate']),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Clr.greyAEAEAE)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            article['title'],
                                            maxLines: 3,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
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
                                                  fontSize: 10,
                                                  color: Clr.greyAEAEAE),
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
                        ),
                      );
                    },
                  )
                : Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Clr.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
