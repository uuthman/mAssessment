import 'package:flutter/cupertino.dart';
import 'package:mon_assessment/core/styles/colors.dart' show AppColors;
import 'package:mon_assessment/core/styles/size_config.dart';
import 'package:mon_assessment/main.dart';

class AppStyles {
  final BuildContext context;
  final AppColors colors = AppColors();
  late final _Text text;

  AppStyles(this.context) {
    text = _Text(context);
  }

  factory AppStyles.init(BuildContext ctx) => AppStyles(ctx);
}

class _Text {
  final BuildContext context;

  _Text(this.context);

  final _fontFamily = "EuclidCircular";

  TextStyle _style(double size, {FontWeight weight = FontWeight.normal}) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(size),
      fontFamily: _fontFamily,
      fontWeight: weight,
    );
  }

  TextStyle get h1 => _style(64);
  TextStyle get h2 => _style(32);
  TextStyle get h3 => _style(24);
  TextStyle get h4 => _style(14);
  TextStyle get title1 => _style(16);
  TextStyle get title2 => _style(14);
  TextStyle get bodyBold => _style(16, weight: FontWeight.bold);



  double _getResponsiveFontSize(double fontSize) {
    double scaleFactor = _getScaleFactor();
    double responsiveFontSize = fontSize * scaleFactor;

    double lowerLimit = fontSize * .8;
    double upperLimit = fontSize * 1.2;

    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  double _getScaleFactor() {
    final width = MediaQuery.sizeOf(context).width;
    if (width <SizeConfig.tablet) {
      return width / 550;
    } else if (width < SizeConfig.desktop) {
      return width / 1000;
    } else {
      return width / 1920;
    }
  }
}
