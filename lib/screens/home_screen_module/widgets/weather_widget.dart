// widgets/weather_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatther_app/providers/weather_provider.dart';

import '../../../providers/setting_provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;
    final useCelsius = Provider.of<SettingsProvider>(context).useCelsius;

    if (weatherData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final temp = weatherData['list'][0]['main']['temp'];
    final condition = weatherData['list'][0]['main']['feels_like'];
    final tempUnit = useCelsius ? '°C' : '°F';
    final displayTemp =
        useCelsius ? temp - 273.15 : (temp - 273.15) * 9 / 5 + 32;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Current Weather',
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text('${displayTemp.toStringAsFixed(1)}$tempUnit'),
            Text(condition.toString()),
            // Add more weather details and forecast here
          ],
        ),
      ),
    );
  }
}
