import 'package:clima_flutter/screens/city_screen.dart';
import 'package:clima_flutter/screens/location_screen.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    if (weatherData == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return CityScreen();
        }),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          size: 80.0,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.white : Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
}
