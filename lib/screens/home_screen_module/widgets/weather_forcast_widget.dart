import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/methods/get_ist_from_timestamp.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/providers/weather_forcast_provider.dart';
import 'package:weatther_app/screens/home_screen_module/methods/get_weather_image_by_title.dart';
import 'package:weatther_app/screens/settings_screen_module/methods/temp.dart';

class WeatherForcastWidget extends StatelessWidget {
  const WeatherForcastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherForcastData =
        Provider.of<WeatherForcastProvider>(context).weatherData['list'];
    final isWeatherForcastLoading =
        Provider.of<WeatherForcastProvider>(context).isLoading;
    final settings = Provider.of<SettingsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'For Next',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey,
            ),
            children: [
              TextSpan(
                text: ' Five days',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Clr.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(24),
            ),
            child: !isWeatherForcastLoading &&
                    weatherForcastData != null &&
                    weatherForcastData.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: weatherForcastData.length,
                    itemBuilder: (context, index) {
                      double? tempKel = double.tryParse(
                          weatherForcastData[index]['main']["temp"].toString());
                      double? pressure = double.tryParse(
                          weatherForcastData[index]['main']["pressure"]
                              .toString());

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr.white),
                              borderRadius: BorderRadius.circular(24)),
                          child: Column(
                            children: [
                              Text(
                                  getISTTimeFromTimestamp(
                                          weatherForcastData[index]['dt'])
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: Clr.greyAEAEAE)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                tempKel != null
                                    ? Temp.convertTemp(
                                                tempInKelvin: tempKel,
                                                covertTo:
                                                    settings.temperatureUnit)
                                            .toString() +
                                        Temp.getAnnotation(
                                            temp: settings.temperatureUnit)
                                    : "--",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${pressure!.toInt().toString()} hPa",
                                  style: TextStyle(
                                      fontSize: 12, color: Clr.greyAEAEAE)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                weatherForcastData[index]['main']["humidity"]
                                        .toString() +
                                    "%".toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Clr.greyAEAEAE),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(weatherForcastData[index]['weather'][0]
                                      ["main"]
                                  .toString()),
                              const SizedBox(
                                height: 5,
                              ),
                              Image.asset(
                                getImageDirByTitle(weatherForcastData[index]
                                        ['weather'][0]["main"]
                                    .toString()),
                                height: 64,
                                width: 64,
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Clr.white,
                    ),
                  )),
          ),
        ),
      ],
    );
  }
}
