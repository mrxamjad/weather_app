// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/providers/news_provider.dart';
import 'package:weatther_app/providers/weather_provider.dart';
import 'package:weatther_app/screens/home_screen_module/widgets/news_widget.dart';

import 'widgets/weather_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch weather and news data when the screen loads
    Future.microtask(() {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeatherData();
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather and News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            WeatherWidget(),
            NewsWidget(),
          ],
        ),
      ),
    );
  }
}
