import 'package:weatther_app/constant/enum.dart';
import 'package:weatther_app/methods/limit_double.dart';

class Temp {
  static String celsius = "Celsius";
  static String fahrenheit = "Fahrenheit";
  static String kelvin = "Kelvin";

  static getTempInString(Temperature temperature) {
    switch (temperature) {
      case Temperature.celsius:
        return celsius;

      case Temperature.fahrenheit:
        return fahrenheit;

      case Temperature.kelvin:
        return kelvin;
      default:
        return kelvin;
    }
  }

  static double convertTemp(
      {required double tempInKelvin, required Temperature covertTo}) {
    switch (covertTo) {
      case Temperature.kelvin:
        return limitDecimalPlaces(tempInKelvin, 2);
      case Temperature.celsius:
        return limitDecimalPlaces((tempInKelvin - 273.15), 2);
      case Temperature.fahrenheit:
        return limitDecimalPlaces((tempInKelvin - 273.15) * 9 / 5 + 32, 2);
      default:
        return tempInKelvin;
    }
  }

  static getAnnotation({required Temperature temp}) {
    switch (temp) {
      case Temperature.kelvin:
        return "°K";
      case Temperature.celsius:
        return "°C";
      case Temperature.fahrenheit:
        return "°F";
      default:
        return "°K";
    }
  }
}
