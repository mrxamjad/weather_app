import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/screens/home_screen_module/home_screen.dart';
import 'package:weatther_app/screens/settings_screen_module/settings_screen.dart';

import 'providers/weather_provider.dart';
import 'providers/news_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        title: 'Weather and News Aggregator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          '/settings': (context) => SettingsScreen(),
        },
      ),
    );
  }
}
