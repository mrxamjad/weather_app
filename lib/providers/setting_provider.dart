// providers/settings_provider.dart
import 'package:flutter/foundation.dart';
import 'package:weatther_app/constant/enum.dart';

class SettingsProvider with ChangeNotifier {
  bool _useCelsius = true;
  List<String> _selectedCategories = [];
  Temperature _temperatureUnit = Temperature.celsius;

  bool get useCelsius => _useCelsius;
  List<String> get selectedCategories => _selectedCategories;
  Temperature get temperatureUnit => _temperatureUnit;

  void toggleTemperatureUnit() {
    _useCelsius = !_useCelsius;
    notifyListeners();
  }

  void updateCategories(List<String> categories) {
    _selectedCategories = categories;
    notifyListeners();
  }

  void updateTempratureUnit(Temperature temp) {
    _temperatureUnit = temp;
    notifyListeners();
  }
}
