// providers/weather_provider.dart
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherForcastProvider with ChangeNotifier {
  Map<String, dynamic> _weatherData = {};
  bool _isLoading = false;

  Map<String, dynamic> get weatherData => _weatherData;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherForcastData(Position latlng) async {
    _isLoading = true;
    notifyListeners();

    const apiKey = 'ce0111071e9f2740af45d5b110869b97';
    String url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${latlng.latitude}&lon=${latlng.longitude}&appid=$apiKey';

    try {
      await http.get(Uri.parse(url)).then((response) {
        if (kDebugMode) {
          print(
              "Status code for waether  forcast api call${response.statusCode}");
          if (response.statusCode == 200) {
            _weatherData = json.decode(response.body);
          } else {
            throw Exception('Failed to load weather forcast data');
          }
        }
      });
    } catch (error) {
      print('Error fetching weather  forcast data: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
