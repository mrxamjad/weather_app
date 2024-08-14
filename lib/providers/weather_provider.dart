// providers/weather_provider.dart
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider with ChangeNotifier {
  Map<String, dynamic> _weatherData = {};
  bool _isLoading = false;

  Map<String, dynamic> get weatherData => _weatherData;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    notifyListeners();

    const apiKey = 'ce0111071e9f2740af45d5b110869b97';
    const url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url)).then((response) {
        if (kDebugMode) {
          print("Status code for waether api call${response.statusCode}");
          if (response.statusCode == 200) {
            _weatherData = json.decode(response.body);
          } else {
            throw Exception('Failed to load weather data');
          }
        }
      });
    } catch (error) {
      print('Error fetching weather data: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
