// providers/news_provider.dart
import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatther_app/repo/news_sentiment.dart';

class NewsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _news = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get news => _news;
  bool get isLoading => _isLoading;

  Future<void> fetchNews(
      {String weather = '',
      String country = "in",
      String category = ""}) async {
    _isLoading = true;
    notifyListeners();

    const apiKey = 'pub_50971ee161dc5ddef00cb1b095c1f181a5b92';

    String url =
        'https://newsdata.io/api/1/latest?apikey=$apiKey&language=en&country=in';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        _news = List<Map<String, dynamic>>.from(data['results']);
        final sentiment = Sentiment();

        final modifiedNews = _news.map((e) {
          final sen = sentiment.analysis(e['title']);
          final weather = NewsSentiment.getWeatherType(sen["comparative"]);

          if (weather == category) {
            return e;
          }

          return e;
        }).toList();

        _news = modifiedNews;
        print("Printing modified news");
        print(modifiedNews.toList());
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching news data: $error');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
