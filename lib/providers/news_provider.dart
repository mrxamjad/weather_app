// providers/news_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _news = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get news => _news;
  bool get isLoading => _isLoading;

  Future<void> fetchNews(
      {String weatherCondition = 'normal',
      String country = "in",
      String category = ""}) async {
    _isLoading = true;
    notifyListeners();

    const apiKey = 'pub_50971ee161dc5ddef00cb1b095c1f181a5b92';

    String url =
        'https://newsdata.io/api/1/latest?apikey=$apiKey&language=en&country=in${category == "" ? "" : "&category=$category"}';

    try {
      final response = await http.get(Uri.parse(url));
      print("News Status code" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        _news = List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print('Error fetching news: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
