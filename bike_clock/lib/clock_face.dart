import 'drawn_hand.dart';
import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' show radians;

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class ClockFace extends StatelessWidget {
  const ClockFace({
    Key key,
    @required this.customTheme,
    @required DateTime now,
  })  : _now = now,
        super(key: key);

  final ThemeData customTheme;
  final DateTime _now;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          // Example of a hand drawn with [CustomPainter].
          DrawnHand(
            color: customTheme.accentColor,
            thickness: 2,
            size: 1,
            angleRadians: _now.second * radiansPerTick,
          ),
          DrawnHand(
            color: customTheme.highlightColor,
            thickness: 4,
            size: 0.8,
            angleRadians: _now.minute * radiansPerTick +
                (_now.second / 60) * radiansPerTick,
          ),
          DrawnHand(
            color: customTheme.primaryColor,
            thickness: 8,
            size: 0.5,
            angleRadians: _now.hour * radiansPerHour +
                (_now.minute / 60) * radiansPerHour,
          ),
        ],
      ),
    );
  }
}
