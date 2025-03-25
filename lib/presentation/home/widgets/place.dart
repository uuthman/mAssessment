import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mon_assessment/main.dart';

class Place extends StatefulWidget {
  const Place({
    super.key,
    this.milliseconds = 3000,
    required this.text,
    required this.imgHeight,
    required this.imgPath,
    required this.sliderWidth,
    required this.animationController,
  });

  final String text;
  final int milliseconds;
  final String imgPath;
  final double imgHeight;
  final double sliderWidth;
  final AnimationController animationController;

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> with SingleTickerProviderStateMixin {
  late Animation<double> _radiusAnimation;
  late AnimationController _expandController;
  late Animation<double> _expandWidthAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _imageFadeAnimation;
  late double _finalContainerWidth;

  static const _imageBorderRadius = 25.0;
  static const _containerHeight = 48.0;
  static const _containerPadding = EdgeInsets.symmetric(horizontal: 8.0);
  static const _containerBottomOffset = 10.0;
  static const _initialContainerWidth = 38.0;
  static const _circleRadiusThreshold = 42.0;
  static const _circleRadius = 21.0;
  static const _expandDuration = Duration(milliseconds: 1000);
  static const _textFadeIntervalStart = 0.2;
  static const _textFadeIntervalEnd = 0.8;
  static const _imageFadeIntervalStart = 0.8;
  static const _imageFadeIntervalEnd = 1.0;
  static const _radiusAnimationStart = 10.0;
  static const _radiusAnimationEnd = 100.0;

  static const _arrowButtonSize = 42.0;
  static const _arrowButtonMargin = EdgeInsets.all(2.0);
  static const _arrowButtonPadding = 8.0;
  static const _arrowIconSize = 10.0;

  @override
  void initState() {
    super.initState();

    _finalContainerWidth = $sizeConfig.width * widget.sliderWidth;

    _imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(
          _imageFadeIntervalStart,
          _imageFadeIntervalEnd,
          curve: Curves.easeIn,
        ),
      ),
    );

    _radiusAnimation = Tween<double>(
      begin: _radiusAnimationStart,
      end: _radiusAnimationEnd,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(
          _imageFadeIntervalStart,
          _imageFadeIntervalEnd,
          curve: Curves.linear,
        ),
      ),
    );

    _expandController = AnimationController(
      vsync: this,
      duration: _expandDuration,
    );

    _expandWidthAnimation = Tween<double>(
      begin: _initialContainerWidth,
      end: _finalContainerWidth,
    ).animate(
      CurvedAnimation(parent: _expandController, curve: Curves.easeOut),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: const Interval(
          _textFadeIntervalStart,
          _textFadeIntervalEnd,
          curve: Curves.easeIn,
        ),
      ),
    );

    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _expandController.forward();
      }
    });
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  Widget _buildArrowButton() {
    return Container(
      width: _arrowButtonSize,
      height: _arrowButtonSize,
      margin: _arrowButtonMargin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: $styles.colors.white.withValues(alpha: 0.6),
      ),
      child: Icon(
        Icons.arrow_forward_ios,
        color: $styles.colors.obsidian950,
        size: _arrowIconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(_imageBorderRadius),
          child: FadeTransition(
            opacity: _imageFadeAnimation,
            child: Image.asset(
              widget.imgPath,
              height: widget.imgHeight,
              width: $sizeConfig.width,
              cacheHeight: widget.imgHeight.floor(),
              cacheWidth: $sizeConfig.width.floor(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: _containerBottomOffset,
          left: 0,
          right: 0,
          child: Padding(
            padding: _containerPadding,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                widget.animationController,
                _expandController,
              ]),
              builder: (context, child) {
                final borderRadius =
                    _expandWidthAnimation.value < _circleRadiusThreshold
                        ? _circleRadius
                        : _radiusAnimation.value;

                return Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: _expandWidthAnimation.value,
                        height: _containerHeight,
                        decoration: BoxDecoration(
                          color: $styles.colors.amber100.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: child,
                      ),
                    ),
                  ),
                );
              },
              child: Stack(
                children: [


                    Positioned(
                      left: 8.0,
                      top: 0,
                      bottom: 0,
                      right:
                          _arrowButtonSize +
                          _arrowButtonMargin.horizontal +
                          _arrowButtonPadding,
                      child: FadeTransition(
                        opacity: _textFadeAnimation,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: $styles.text.title1.copyWith(
                              color: $styles.colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: _buildArrowButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
