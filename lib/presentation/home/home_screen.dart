import 'package:flutter/material.dart';
import 'package:mon_assessment/core/assets.dart';
import 'package:mon_assessment/presentation/home/widgets/gallery.dart';
import 'package:mon_assessment/presentation/home/widgets/info.dart';
import 'package:mon_assessment/presentation/home/widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandTextAnimation;
  late final Animation<double> _circleRowOpacityAnimation;
  late final Animation<double> _gallerySlideAnimation;
  bool _hasPrecachedImages = false;



  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();

    _expandTextAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.5, curve: Curves.easeOut),
      ),
    );

    _circleRowOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
      ),
    );

    _gallerySlideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasPrecachedImages) {
      try {
        precacheImage(AssetImage(ImagePaths.place1), context);
        precacheImage(AssetImage(ImagePaths.place2), context);
        precacheImage(AssetImage(ImagePaths.place3), context);
        precacheImage(AssetImage(ImagePaths.place4), context);
        _hasPrecachedImages = true;
      } catch (e) {
        debugPrint('Error pre-caching image: $e');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with text expansion animation
                Header(
                  expandTextProgress: _expandTextAnimation.value,
                  animationController: _controller,
                ),
                SizedBox(
                  height: _circleRowOpacityAnimation.value > 0.5 ? 18 : 20,
                ),
                // Info section
                Info(animationController: _controller),
                const SizedBox(height: 40),
                if (_gallerySlideAnimation.value < 1)
                  Transform.translate(
                    offset: Offset(0, _gallerySlideAnimation.value * 200),
                    child: child,
                  ),
              ],
            );
          },
          child: Gallery(animationController: _controller),
        ),
      ),
    );
  }
}