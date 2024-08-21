// screens/home_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weatther_app/constant/directory.dart';
import 'package:weatther_app/constant/enum.dart';
import 'package:weatther_app/constant/pref_key.dart';
import 'package:weatther_app/providers/news_provider.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/providers/weather_forcast_provider.dart';
import 'package:weatther_app/providers/weather_provider.dart';
import 'package:weatther_app/repo/fetch_current_location.dart';
import 'package:weatther_app/repo/sharedprefrences_service.dart';
import 'package:weatther_app/screens/home_screen_module/widgets/news_widget.dart';
import 'package:weatther_app/screens/home_screen_module/widgets/top_bar_widget.dart';
import 'package:weatther_app/screens/home_screen_module/widgets/weather_forcast_widget.dart';

import 'widgets/weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch weather and news data when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SharedPrefrencesService().getStringData(PrefKey.tempUnit).then((value) {
        if (value != null) {
          Temperature tmp;
          if (value == "Temperature.celsius") {
            tmp = Temperature.celsius;
          } else if (value == "Temperature.fahrenheit") {
            tmp = Temperature.fahrenheit;
          } else {
            tmp = Temperature.kelvin;
          }

          Provider.of<SettingsProvider>(context, listen: false)
              .updateTempratureUnit(tmp);
        }
      });
    });
    Future.microtask(() {
      final settings = Provider.of<SettingsProvider>(context, listen: false);
      if (kDebugMode) {
        print(settings.selectedCategories.toList());
      }
      LocationSerice.getCurrentLocation().then((latlng) {
        if (latlng != null) {
          Provider.of<WeatherProvider>(context, listen: false)
              .fetchWeatherData(latlng)
              .then((value) {
            final mood = Provider.of<WeatherProvider>(context, listen: false)
                .weatherData['weather'][0]['main'];
            if (mood != null) {
              Provider.of<NewsProvider>(context, listen: false)
                  .fetchNews(category: "");
            }
          });
          Provider.of<WeatherForcastProvider>(context, listen: false)
              .fetchWeatherForcastData(latlng);
        } else {}
      });
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        TopBarWidget(),
                        SizedBox(
                          height: 42,
                        ),
                        WeatherWidget(),
                        SizedBox(height: 24),
                        SizedBox(height: 288, child: WeatherForcastWidget()),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  NewsWidget(),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
