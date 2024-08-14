// screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/providers/setting_provider.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> newsCategories = [
    'general',
    'business',
    'technology',
    'sports',
    'entertainment',
    'health',
    'science',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Temperature Unit'),
                trailing: Switch(
                  value: settings.useCelsius,
                  onChanged: (value) {
                    settings.toggleTemperatureUnit();
                  },
                ),
                subtitle: Text(settings.useCelsius ? 'Celsius' : 'Fahrenheit'),
              ),
              const Divider(),
              ListTile(
                title: Text('News Categories'),
                subtitle: Text('Select categories you\'re interested in'),
              ),
              ...newsCategories.map((category) {
                return CheckboxListTile(
                  title: Text(category.capitalize()),
                  value: settings.selectedCategories.contains(category),
                  onChanged: (bool? value) {
                    if (value != null) {
                      List<String> updatedCategories =
                          List.from(settings.selectedCategories);
                      if (value) {
                        updatedCategories.add(category);
                      } else {
                        updatedCategories.remove(category);
                      }
                      settings.updateCategories(updatedCategories);
                    }
                  },
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
