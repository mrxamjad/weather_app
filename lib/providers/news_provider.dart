// providers/news_provider.dart
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _news = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get news => _news;
  bool get isLoading => _isLoading;

  Future<void> fetchNews({String weatherCondition = 'normal'}) async {
    _isLoading = true;
    notifyListeners();

    final apiKey = '42ad661b8a1442ec9e15afc57c03a225';
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    // Weather-based news filtering
    switch (weatherCondition.toLowerCase()) {
      case 'cold':
        url += '&q=depression';
        break;
      case 'hot':
        url += '&q=fear';
        break;
      case 'cool':
        url += '&q=(winning OR happiness)';
        break;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _news = List<Map<String, dynamic>>.from(data['articles']);
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
