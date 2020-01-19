// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

abstract class Hand extends StatelessWidget {
  const Hand({
    @required this.color,
    @required this.size,
    @required this.angleRadians,
  })  : assert(color != null),
        assert(size != null),
        assert(angleRadians != null);

  /// Hand color.
  final Color color;

  /// Hand length, as a percentage of the smaller side of the clock's parent
  /// container.
  final double size;

  /// The angle, in radians, at which the hand is drawn.
  ///
  /// This angle is measured from the 12 o'clock position.
  final double angleRadians;
}
