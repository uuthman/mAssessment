import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_assessment/main.dart';
import 'package:mon_assessment/presentation/main/widgets/nav_icon.dart';

class AppBottomNavBar extends StatefulWidget {
  final List<String> icons;
  final Function(int) onClick;
  final int initialIndex;

  const AppBottomNavBar({
    super.key,
    required this.icons,
    required this.onClick,
    this.initialIndex = 2,
  });

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _controller;
  bool _showNavEffect = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showNavEffect = false);
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelect(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    widget.onClick(index);
    _triggerEffect();
  }

  void _triggerEffect() {
    setState(() => _showNavEffect = true);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: $sizeConfig.width,
      height: $sizeConfig.height * 0.08,
      child: Card(
        color: $styles.colors.graphite800,
        shape: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.icons
                .asMap()
                .entries
                .map((entry) => _buildNavIcon(entry.key))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(int index) {
    final isSelected = _currentIndex == index;
    final baseColor = $styles.colors.obsidian950;
    final activeColor = $styles.colors.amber600;

    return NavIcon(
      onClick: () => _onSelect(index),
      height: isSelected ? 53 : 45,
      width: isSelected ? 53 : 45,
      decoration: BoxDecoration(
        color: isSelected && !_showNavEffect
            ? activeColor
            : isSelected
            ? $styles.colors.white
            : baseColor,
        shape: BoxShape.circle,
        border: _showNavEffect && isSelected
            ? Border.all(color: Colors.white, width: 1)
            : null,
      ),
      isClicked: isSelected,
      isStrokeVisible: _showNavEffect,
      controller: _controller,
      strokeWidth: 1,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected && !_showNavEffect ? activeColor : baseColor,
        ),
        child: SvgPicture.asset(
          widget.icons[index],
          fit: BoxFit.none,
        ),
      ),
    );
  }
}