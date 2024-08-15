import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weatther_app/methods/get_ist_from_timestamp.dart';
import 'package:weatther_app/providers/setting_provider.dart';
import 'package:weatther_app/providers/weather_forcast_provider.dart';
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

    if (isWeatherForcastLoading) {
      return SizedBox(child: CircularProgressIndicator());
    } else {
      final weatherForcastProvider =
          Provider.of<WeatherForcastProvider>(context).weatherData;
      final String country = weatherForcastProvider["city"]["country"];
      final String city = weatherForcastProvider["city"]["name"];

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text(city), Text(country)],
          ),
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Date"),
                      Text(
                          "Temprature (${Temp.getAnnotation(temp: settings.temperatureUnit)})"),
                      Text("Pressure"),
                      Text("Humidity"),
                      Text("Weather"),
                      Text("Descroption"),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: weatherForcastData.length,
                      itemBuilder: (context, index) {
                        double? tempKel = double.tryParse(
                            weatherForcastData[index]['main']["temp"]
                                .toString());
                        double? pressure = double.tryParse(
                            weatherForcastData[index]['main']["pressure"]
                                .toString());

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(getISTTimeFromTimestamp(
                                      weatherForcastData[index]['dt'])
                                  .toString()),
                              Text(tempKel != null
                                  ? Temp.convertTemp(
                                          tempInKelvin: tempKel,
                                          covertTo: settings.temperatureUnit)
                                      .toString()
                                  : "--"),
                              Text("${pressure ?? "--"}"),
                              Text(weatherForcastData[index]['main']["humidity"]
                                  .toString()),
                              Text(weatherForcastData[index]['weather'][0]
                                      ["main"]
                                  .toString()),
                              Text(weatherForcastData[index]['weather'][0]
                                      ["description"]
                                  .toString()),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
