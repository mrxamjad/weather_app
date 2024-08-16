// screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/constant/enum.dart';
import 'package:weatther_app/constant/pref_key.dart';
import 'package:weatther_app/providers/news_provider.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/providers/weather_provider.dart';
import 'package:weatther_app/repo/news_sentiment.dart';
import 'package:weatther_app/repo/sharedprefrences_service.dart';
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

  SettingsScreen({super.key});

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text("Temprature Unit"),
                    const Spacer(),
                    DropdownButton<Temperature>(
                      value: settings.temperatureUnit,
                      underline: const SizedBox(),
                      onChanged: (value) {
                        if (value != null) {
                          settings.updateTempratureUnit(value);
                          SharedPrefrencesService().saveStringData(
                              PrefKey.tempUnit,
                              settings.temperatureUnit.toString());
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
              ),
              Divider(
                  height: 0.25,
                  thickness: 0.25,
                  color: Clr.greyAEAEAE.withOpacity(0.5)),
              const ListTile(
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
                      final mood =
                          Provider.of<WeatherProvider>(context, listen: false)
                              .weatherData['weather'][0]['main'];
                      settings.updateCategories(updatedCategories);
                      String cat = settings.selectedCategories.join(',');

                      Provider.of<NewsProvider>(context, listen: false)
                          .fetchNews(
                              category: cat,
                              weather:
                                  NewsSentiment().weatherSentimentMap[mood] ??
                                      "");
                    }
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
