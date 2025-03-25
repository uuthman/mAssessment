import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mon_assessment/core/assets.dart';
import 'package:mon_assessment/main.dart';
import 'package:mon_assessment/presentation/main/widgets/nav_icon.dart';
import 'package:mon_assessment/presentation/map/widgets/fab_button.dart';

class MapActionsFab extends StatefulWidget {
  const MapActionsFab({super.key, required this.animationController});
  final AnimationController animationController;

  @override
  State<MapActionsFab> createState() => _OverlayDialogState();
}

class _OverlayDialogState extends State<MapActionsFab>
    with TickerProviderStateMixin {
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();
  final OverlayPortalController _overlayPortalController2 =
      OverlayPortalController();
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  int iconIndex = 0;
  late Animation<double> _animation;
  late double _begin, _end;
  bool _onHideBorder = false;

  final options = [
    'Cosy areas',
    'Price',
    'Infrastructure',
    'Without any layer',
  ];

  final List<GlobalKey> _navIconKeys = [GlobalKey(), GlobalKey()];

  double? _overlayTopPosition;

  @override
  void initState() {
    _begin = 20;
    _end = 15;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.linear,
    );

    _rippleAnimation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hideBorder();
        _controller.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _hideBorder() {
    setState(() {
      _onHideBorder = false;
    });
  }

  void _onDisplayBorder() {
    setState(() {
      _onHideBorder = true;
    });
  }

  void _calculateOverlayPosition(int index) {
    final RenderBox renderBox =
        _navIconKeys[index].currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final iconHeight = renderBox.size.height;

    setState(() {
      _overlayTopPosition =
          position.dy - (iconHeight * 2.5);
    });
  }

  void _onTap(int index) {
    _onDisplayBorder();
    _controller.forward();
    _calculateOverlayPosition(
      index,
    );
    setState(() {
      widget.animationController.forward();
      if (index == 0) {
        _overlayPortalController.show();
      } else {
        _overlayPortalController2.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            ...List.generate(
              2,
              (index) => OverlayPortal(
                controller:
                    [
                      _overlayPortalController,
                      _overlayPortalController2,
                    ][index],
                overlayChildBuilder: (context) {
                  return Positioned(
                    top: _overlayTopPosition, // Use dynamic top position
                    left: 0,
                    child: Transform.scale(
                      scale: _animation.value,
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: $styles.colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            options.length,
                            (idx) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.animationController.reverse();
                                });
                              },
                              child: Row(
                                spacing: 10,
                                children: [
                                  SvgPicture.asset(
                                    [
                                      ImagePaths.shield,
                                      ImagePaths.wallet,
                                      ImagePaths.trash,
                                      ImagePaths.layer,
                                    ][idx],
                                    height: 20,
                                    color:
                                        idx == 1
                                            ? $styles.colors.amber600
                                            : $styles.colors.obsidian950
                                                .withValues(alpha: 0.4),
                                  ),
                                  Text(
                                    options[idx],
                                    style: $styles.text.title1.copyWith(
                                      color:
                                          idx == 1
                                              ? $styles.colors.amber600
                                              : $styles.colors.obsidian950
                                                  .withValues(alpha: 0.4),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    FabButton(
                      key: _navIconKeys[index],
                      onTap: () {
                        _onTap(index);
                        setState(() {
                          iconIndex = index;
                        });
                      },
                      showRipple: iconIndex == index,
                      onHideBorder: _onHideBorder,
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: $styles.colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border:
                            !_onHideBorder
                                ? null
                                : Border.all(
                                  color: $styles.colors.white.withValues(
                                    alpha: 0.8,
                                  ),
                                  width: 1,
                                ),
                      ),
                      strokeWidth: 3,
                      index: index,
                      rippleAnimation: _rippleAnimation,
                      child: Transform.rotate(
                        angle: index == 0 ? 0 : 1.0,
                        child: SvgPicture.asset(
                          index == 0 ? ImagePaths.layer : ImagePaths.mapArrow,
                          color: $styles.colors.white.withValues(alpha: 0.8),
                          fit: BoxFit.none,
                          height: 8,
                          width: 8,
                        ),
                      ),
                    ).animate(
                      delay: 200.ms,
                    ).scale(
                      duration:1500.ms,
                      curve:  Curves.easeOut,
                    ),
                    if (index == 0) ...[const SizedBox(height: 12)],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
