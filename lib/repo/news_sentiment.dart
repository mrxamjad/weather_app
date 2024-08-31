class NewsSentiment {
  List<String> weathers = [
    "Thunderstorm",
    "Drizzle",
    "Rain",
    "Snow",
    "Atmosphere",
    "Clear",
    "Clouds",
  ];

  static String getWeatherType(double sentiment) {
    final weatherTypes = [
      'Clear',
      'Snow',
      'Clouds',
      'Rain',
      'Drizzle',
      'Atmosphere',
      'Thunderstorm'
    ];

    if (sentiment < -0.5) {
      return weatherTypes[6]; // Thunderstorm
    } else if (sentiment >= -0.5 && sentiment < -0.25) {
      return weatherTypes[4]; // Drizzle
    } else if (sentiment >= -0.25 && sentiment < 0.25) {
      return weatherTypes[3]; // Rain
    } else if (sentiment >= 0.25 && sentiment < 0.5) {
      return weatherTypes[1]; // Snow
    } else if (sentiment >= 0.5 && sentiment < 0.75) {
      return weatherTypes[5]; // Atmosphere
    } else if (sentiment >= 0.75 && sentiment < 0.9) {
      return weatherTypes[0]; // Clear
    } else {
      return weatherTypes[2]; // Clouds
    }
  }
}
