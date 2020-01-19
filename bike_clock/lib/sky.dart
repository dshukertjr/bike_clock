import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class Sky extends StatelessWidget {
  final WeatherCondition weatherCondition;

  const Sky({Key key, @required this.weatherCondition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors;
    switch (weatherCondition) {
      case WeatherCondition.sunny:
        colors = [
          Colors.lightBlue,
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
        ];
        break;
      case WeatherCondition.cloudy:
        colors = [
          Colors.blueGrey,
          Colors.white,
        ];
        break;
      case WeatherCondition.rainy:
        colors = [
          Colors.blueGrey,
          Colors.white,
        ];
        break;
      case WeatherCondition.thunderstorm:
        colors = [
          Colors.blueGrey,
          Colors.white,
        ];
        break;
      default:
        colors = [
          Colors.white,
          Colors.white,
        ];
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
    );
  }
}
