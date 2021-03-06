// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:bike_clock/sky.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'clock_face.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

class BikeClock extends StatefulWidget {
  const BikeClock(this.model);

  final ClockModel model;

  @override
  _BikeClockState createState() => _BikeClockState();
}

class _BikeClockState extends State<BikeClock> {
  var _now = DateTime.now();
  WeatherCondition _weatherCondition = WeatherCondition.sunny;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(BikeClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _weatherCondition = widget.model.weatherCondition;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();

      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).copyWith(
      // Hour hand.
      primaryColor: Color(0xFFFFFFFF),
      // Minute hand.
      highlightColor: Color(0xFFFFFFFF),
      // Second hand.
      accentColor: Color(0xFFFFFFFF),
      backgroundColor: Color(0xFF000000),
    );

    final time = DateFormat.Hms().format(DateTime.now());

    final clockFaceRatio = .4;

    double timeShade = .0;
    final hour = _now.hour;
    final minute = _now.minute;
    if (hour < 5) {
      timeShade = .5;
    } else if (5 <= hour && hour < 7) {
      timeShade = (7 - hour - (minute / 60)) * .25;
    } else if (7 <= hour && hour < 17) {
      timeShade = .0;
    } else if (17 <= hour && hour < 19) {
      timeShade = (-17 + hour + minute / 60) * .25;
    } else {
      timeShade = .5;
    }

    // WeatherCondition some = WeatherCondition.;

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Sky(
            weatherCondition: _weatherCondition,
            timeShadow: timeShade,
          ),
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
          ),
          FlareActor(
            'assets/bike.flr',
            animation: 'rotateTire',
          ),
          Container(
            color: Colors.black.withOpacity(timeShade),
          ),
          FractionallySizedBox(
            alignment: Alignment(-.66, .573),
            widthFactor: clockFaceRatio,
            heightFactor: clockFaceRatio,
            child: ClockFace(
              customTheme: customTheme,
              now: _now,
            ),
          ),
          if (_weatherCondition == WeatherCondition.snowy)
            FlareActor(
              'assets/snow.flr',
              animation: 'snow',
            ),
          if (_weatherCondition == WeatherCondition.rainy)
            FlareActor(
              'assets/rain.flr',
              animation: 'rain',
            ),
          if (_weatherCondition == WeatherCondition.thunderstorm)
            FlareActor(
              'assets/rain.flr',
              animation: 'thunder',
            ),
          if (_weatherCondition == WeatherCondition.windy)
            FlareActor(
              'assets/wind.flr',
              animation: 'wind',
            ),
          if (_weatherCondition == WeatherCondition.foggy)
            Container(
              color: Colors.white.withOpacity(0.4),
            ),
        ],
      ),
    );
  }
}
