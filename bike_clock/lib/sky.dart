import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class Sky extends StatelessWidget {
  final WeatherCondition weatherCondition;
  final double timeShadow;

  const Sky({
    Key key,
    @required this.weatherCondition,
    @required this.timeShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors;
    double skyFrontLayerOpacity = 1;
    switch (weatherCondition) {
      case WeatherCondition.sunny:
        if (timeShadow == 0) {
          colors = [
            Colors.lightBlue,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
          ];
        } else if (timeShadow == .5) {
          colors = [
            Colors.transparent,
            Colors.transparent,
          ];
          skyFrontLayerOpacity = 0;
        } else {
          colors = [
            Colors.lightBlue,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
          ];
          skyFrontLayerOpacity = 1 - timeShadow / .5;
        }
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

    return Stack(
      children: <Widget>[
        Image.asset('assets/nightSky.png'),
        Opacity(
          opacity: skyFrontLayerOpacity,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
