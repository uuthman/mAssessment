import 'package:flutter/material.dart';

class SizeConfig {
  static final SizeConfig _instance = SizeConfig._internal();

  factory SizeConfig() => _instance;

  static SizeConfig get instance => _instance;

  static const double desktop = 1200;
  static const double tablet = 800;

  late double width, height;

  SizeConfig._internal();

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _instance.width = size.width;
    _instance.height = size.height;
  }
}