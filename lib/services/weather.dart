import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';
import 'package:clima_flutter/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    String url =
        '$API_URL?units=metric&lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData().catchError((e) {
      print(e);
      return null;
    });
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$API_URL?units=metric&q=$cityName&appid=$API_KEY';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData().catchError((e) {
      print(e);
      return null;
    });
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
