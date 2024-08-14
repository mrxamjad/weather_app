// providers/settings_provider.dart
import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  bool _useCelsius = true;
  List<String> _selectedCategories = ['general'];

  bool get useCelsius => _useCelsius;
  List<String> get selectedCategories => _selectedCategories;

  void toggleTemperatureUnit() {
    _useCelsius = !_useCelsius;
    notifyListeners();
  }

  void updateCategories(List<String> categories) {
    _selectedCategories = categories;
    notifyListeners();
  }
}
