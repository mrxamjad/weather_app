// widgets/weather_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Current Weather',
            ),
            const SizedBox(height: 8),
            Text(Temp.convertTemp(
                        tempInKelvin: temp, covertTo: settings.temperatureUnit)
                    .toString() +
                Temp.getAnnotation(temp: settings.temperatureUnit)),
            Text(condition.toString()),
            Text(condition.toString()),
            Text(condition.toString()),
            // Add more weather details and forecast here
          ],
        ),
      ),
    );
  }
}
