// screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/constant/enum.dart';
import 'package:weatther_app/providers/news_provider.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/screens/settings_screen_module/methods/temp.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> newsCategories = [
    'education',
    'sports',
    'entertainment',
    'health',
    'science',
  ];

  final dropdownValue = "kelvin";

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
              Row(
                children: [
                  Text("Temprature Unit"),
                  Spacer(),
                  DropdownButton<Temperature>(
                    value: settings.temperatureUnit,
                    onChanged: (value) {
                      if (value != null) {
                        settings.updateTempratureUnit(value);
                      }
                    },
                    items: <Temperature>[
                      Temperature.celsius,
                      Temperature.fahrenheit,
                      Temperature.kelvin
                    ].map<DropdownMenuItem<Temperature>>((Temperature value) {
                      return DropdownMenuItem<Temperature>(
                        value: value,
                        child: Text(Temp.getTempInString(value)),
                      );
                    }).toList(),
                  ),
                ],
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
                      String cat = settings.selectedCategories.join(',');

                      Provider.of<NewsProvider>(context, listen: false)
                          .fetchNews(category: cat);

                      print(cat);
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
