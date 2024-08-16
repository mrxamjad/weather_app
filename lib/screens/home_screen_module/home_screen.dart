// screens/home_screen.dart

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weatther_app/constant/directory.dart';
import 'package:weatther_app/providers/news_provider.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/providers/weather_forcast_provider.dart';
import 'package:weatther_app/providers/weather_provider.dart';
import 'package:weatther_app/repo/fetch_current_location.dart';
import 'package:weatther_app/screens/home_screen_module/widgets/news_widget.dart';
import 'package:weatther_app/screens/home_screen_module/widgets/top_bar_widget.dart';
import 'package:weatther_app/screens/home_screen_module/widgets/weather_forcast_widget.dart';

import 'widgets/weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch weather and news data when the screen loads
    Future.microtask(() {
      final settings = Provider.of<SettingsProvider>(context, listen: false);
      print(settings.selectedCategories.toList());
      LocationSerice.getCurrentLocation().then((latlng) {
        if (latlng != null) {
          Provider.of<WeatherProvider>(context, listen: false)
              .fetchWeatherData(latlng);
          Provider.of<WeatherForcastProvider>(context, listen: false)
              .fetchWeatherForcastData(latlng);
        } else {}
      });

      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Dir.homeBg),
          const SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TopBarWidget(),
                    SizedBox(
                      height: 42,
                    ),
                    WeatherWidget(),
                    SizedBox(height: 24),
                    SizedBox(height: 288, child: WeatherForcastWidget()),
                    NewsWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
