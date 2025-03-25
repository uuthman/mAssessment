import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mon_assessment/core/assets.dart';
import 'package:mon_assessment/presentation/home/home_screen.dart';
import 'package:mon_assessment/presentation/main/widgets/app_bottom_nav_bar.dart';
import 'package:mon_assessment/presentation/map/map_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;

  static const List<Widget> _screens = [
    MapScreen(),
    Placeholder(),
    HomeScreen(),
    Placeholder(),
    Placeholder(),
  ];

  static final List<String> _navItems = [
    ImagePaths.search,
    ImagePaths.chat,
    ImagePaths.home,
    ImagePaths.heart,
    ImagePaths.profile,
  ];

  static const BoxDecoration _backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFF8F8F7),
        Color(0xFFF8F8F7),
        Color(0xFFF6DDC1),
        Color(0xFFFAD8B0),
        Color(0xFFFAD8B0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  void _updateIndex(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _backgroundDecoration,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _screens[_currentIndex],
            Positioned(
              bottom: 25,
              left: 50,
              right: 50,
              child: AppBottomNavBar(
                icons: _navItems,
                onClick: _updateIndex,
                initialIndex: _currentIndex,
              ),
            ).animate(delay: 4200.ms).slideY(
              duration: 800.ms,
              begin: 1.3,
              end: 0,
              curve: Curves.linear,
            ),
          ],
        ),
      ),
    );
  }
}