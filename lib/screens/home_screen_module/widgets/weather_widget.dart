// widgets/weather_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/providers/weather_provider.dart';
import 'package:weatther_app/screens/settings_screen_module/methods/temp.dart';

import '../../../providers/setting_provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;

    final settings = Provider.of<SettingsProvider>(context);

    if (weatherData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final temp = weatherData['main']['temp'];
    final condition = weatherData['weather'][0]['main'];
    // final location=weatherData['']

    return Column(
      children: [
        Text(
          weatherData['name'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          Temp.convertTemp(
                      tempInKelvin: temp, covertTo: settings.temperatureUnit)
                  .toInt()
                  .toString() +
              Temp.getAnnotation(temp: settings.temperatureUnit),
          style: const TextStyle(fontSize: 96, fontWeight: FontWeight.w500),
        ),
        Text(
          condition.toString(),
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          weatherData["weather"][0]["description"].toString(),
          style: TextStyle(
            fontSize: 12,
            color: Clr.black,
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              color: Clr.white, borderRadius: BorderRadius.circular(24)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  Icons.sunny,
                  color: Clr.greyAEAEAE,
                  size: 12,
                ),
                Text(
                  "UV Index",
                  style: TextStyle(fontSize: 12, color: Clr.greyAEAEAE),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "7",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Clr.black)),
                      TextSpan(
                          text: "High",
                          style:
                              TextStyle(fontSize: 12, color: Clr.greyAEAEAE)),
                    ],
                  ),
                ),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  Icons.sunny,
                  color: Clr.greyAEAEAE,
                  size: 12,
                ),
                Text(
                  "Humidity",
                  style: TextStyle(fontSize: 12, color: Clr.greyAEAEAE),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "${weatherData["main"]["humidity"]}%",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Clr.black)),
                    ],
                  ),
                ),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  Icons.sunny,
                  color: Clr.greyAEAEAE,
                  size: 12,
                ),
                Text(
                  "Pressure",
                  style: TextStyle(fontSize: 12, color: Clr.greyAEAEAE),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "${weatherData["main"]["pressure"]}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Clr.black)),
                      TextSpan(
                          text: "hPa",
                          style:
                              TextStyle(fontSize: 12, color: Clr.greyAEAEAE)),
                    ],
                  ),
                ),
              ])
            ],
          ),
        )
      ],
    );
  }
}
