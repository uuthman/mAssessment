import 'package:flutter/material.dart';
import 'package:mon_assessment/core/logic/app_logic.dart';
import 'package:mon_assessment/core/styles/size_config.dart';
import 'package:mon_assessment/core/styles/styles.dart';
import 'package:mon_assessment/main.dart';
import 'package:mon_assessment/presentation/widgets/app_scroll_behavior.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;
  static late AppStyles _style;
  static AppStyles get style => _style;

  static SizeConfig get config => SizeConfig.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    _style = AppStyles(context);
    final mediaQuery = MediaQuery.of(context);
    AppLogic().handleSizeChange(mediaQuery.size);

    _style = AppStyles.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: child,
      builder: (context,child) {
        return Theme(
          data: $styles.colors.toThemeData(),
          child: ScrollConfiguration(behavior: AppScrollBehavior(), child: child!),
        );
      }
    );
  }
}
