import 'package:flutter/material.dart';
import 'package:mon_assessment/core/styles/size_config.dart';
import 'package:mon_assessment/core/styles/styles.dart';
import 'package:mon_assessment/presentation/app_scaffold.dart';
import 'package:mon_assessment/presentation/main/main_screen.dart';
import 'package:mon_assessment/presentation/map/map_screen.dart';

void main() {
  runApp(const AppScaffold(child: MainScreen()));
}


/// Global helpers
AppStyles get $styles => AppScaffold.style;
SizeConfig get $sizeConfig => AppScaffold.config;


