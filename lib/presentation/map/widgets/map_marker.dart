import 'package:flutter/material.dart';
import 'package:mon_assessment/main.dart';

class MapMarker extends StatefulWidget {
  final bool isExpanded;

  const MapMarker({super.key, required this.isExpanded});

  @override
  State<MapMarker> createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  static const List<Map<String, dynamic>> _markerData = [
    {'top': 0.23, 'left': 0.3, 'price': '10,3 mn ₽'},
    {'top': 0.295, 'left': 0.35, 'price': '11 mn ₽'},
    {'top': 0.5, 'left': 0.2, 'price': '13,3 mn ₽'},
    {'top': 0.32, 'left': 0.7, 'price': '7,8 mn ₽'},
    {'top': 0.45, 'left': 0.7, 'price': '8,5 mn ₽'},
    {'top': 0.55, 'left': 0.6, 'price': '6,95 mn ₽'},
  ];

  static final BoxDecoration _markerDecoration = BoxDecoration(
    color: $styles.colors.amber600,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomRight: Radius.circular(12),
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: _markerData.map((data) {
        final index = _markerData.indexOf(data);
        return _buildMarker(
          top: $sizeConfig.height * data['top'],
          left: $sizeConfig.width * data['left'],
          price: data['price'],
          isExpanded: widget.isExpanded,
        );
      }).toList(),
    );
  }

  Widget _buildMarker({
    required double top,
    required double left,
    required String price,
    required bool isExpanded,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Align(
            alignment: Alignment.bottomLeft,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              alignment: Alignment.bottomLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                width: isExpanded ? 75 : 35,
                padding: EdgeInsets.symmetric(
                  horizontal: isExpanded ? 12 : 8,
                  vertical: 12,
                ),
                decoration: _markerDecoration,
                child: isExpanded
                    ? Text(
                  price,
                  style:  $styles.text.title1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                )
                    :  Icon(
                  Icons.apartment_rounded,
                  color: $styles.colors.white,
                  size: 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}