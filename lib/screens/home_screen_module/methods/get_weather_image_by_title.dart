import 'package:weatther_app/constant/directory.dart';

String getImageDirByTitle(String imageTitle) {
  switch (imageTitle) {
    case "Clouds":
      return Dir.cloudWeatherIcon;
    case "Rain":
      return Dir.rainWeatherIcon;
    default:
      return Dir.cloudWeatherIcon;
  }
}
