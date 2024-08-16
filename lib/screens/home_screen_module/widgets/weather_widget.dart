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
    final isWeatherLoading = Provider.of<WeatherProvider>(context).isLoading;
    final settings = Provider.of<SettingsProvider>(context);

    return !isWeatherLoading
        ? Consumer<WeatherProvider>(builder: (context, weather, child) {
            final weatherData = weather.weatherData;

            if (weatherData.isEmpty) {
              return const Center(child: Text('No weather data available'));
            }

            return Column(
              children: [
                Text(
                  weatherData['name'] ?? 'Unknown Location',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  _getTemperatureText(weatherData, settings),
                  style: const TextStyle(
                      fontSize: 96, fontWeight: FontWeight.w500),
                ),
                Text(
                  _getWeatherMain(weatherData),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  _getWeatherDescription(weatherData),
                  style: TextStyle(fontSize: 12, color: Clr.black),
                ),
                const SizedBox(height: 36),
                _buildWeatherDetailsContainer(weatherData),
              ],
            );
          })
        : SizedBox(
            height: 350,
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(color: Clr.white),
              ),
            ),
          );
  }

  String _getTemperatureText(
      Map<String, dynamic> weatherData, SettingsProvider settings) {
    final temp = weatherData['main']?['temp'];

    if (temp == null) return "--";

    return '${Temp.convertTemp(tempInKelvin: double.parse(temp.toString()), covertTo: settings.temperatureUnit).toInt()}${Temp.getAnnotation(temp: settings.temperatureUnit)}';
  }

  String _getWeatherMain(Map<String, dynamic> weatherData) {
    return weatherData['weather']?[0]?['main']?.toString() ?? 'Unknown';
  }

  String _getWeatherDescription(Map<String, dynamic> weatherData) {
    return weatherData['weather']?[0]?['description']?.toString() ??
        'No description available';
  }

  Widget _buildWeatherDetailsContainer(Map<String, dynamic> weatherData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Clr.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailColumn('UV Index', '7', 'High'),
          _buildDetailColumn('Humidity',
              '${weatherData['main']?['humidity'] ?? 'N/A'}%', null),
          _buildDetailColumn('Pressure',
              '${weatherData['main']?['pressure'] ?? 'N/A'}', 'hPa'),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String title, String value, String? subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.sunny, color: Clr.greyAEAEAE, size: 12),
        Text(title, style: TextStyle(fontSize: 12, color: Clr.greyAEAEAE)),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: value,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Clr.black)),
              if (subtitle != null)
                TextSpan(
                    text: subtitle,
                    style: TextStyle(fontSize: 12, color: Clr.greyAEAEAE)),
            ],
          ),
        ),
      ],
    );
  }
}
