import 'dart:ui';

import 'package:flutter/services.dart';

class AppLogic {

  Display get display => PlatformDispatcher.instance.displays.first;


  void handleSizeChange(Size size) {

    final orientations = <DeviceOrientation>[];

    orientations.addAll(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
    );


    bool isSmall = display.size.shortestSide / display.devicePixelRatio < 600;

    if(!isSmall) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ]);
    }

    SystemChrome.setPreferredOrientations(orientations);
  }
}