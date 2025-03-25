import 'package:flutter/material.dart';
import 'package:mon_assessment/main.dart';

class Info extends StatelessWidget {
  const Info({super.key, required this.animationController});

  final AnimationController animationController;

  static const _padding = EdgeInsets.symmetric(horizontal: 16);
  static const _cardSpacing = 46.0;
  static const _cardHeight = 180.0;
  static const _cardWidthFactor = 0.45;
  static const _cardBorderRadius = 25.0;
  static const _cardShadowBlurRadius = 10.0;
  static const _cardShadowSpreadRadius = 2.0;
  static const _greetingAnimationIntervalStart = 0.4;
  static const _greetingAnimationIntervalEnd = 0.6;
  static const _cardAnimationIntervalStart = 0.5;
  static const _cardAnimationIntervalEnd = 0.6;
  static const _countAnimationIntervalStart = 0.6;
  static const _countAnimationIntervalEnd = 0.9;
  static const _descriptionSlideIntervalStart = 0.6;
  static const _descriptionSlideIntervalEnd = 0.9;
  static const _descriptionFadeIntervalStart = 0.63;
  static const _descriptionFadeIntervalEnd = 0.9;

  Widget _buildDescription() {
    const descriptionLines = ["let's select your", "perfect place"];

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(
              _descriptionSlideIntervalStart,
              _descriptionSlideIntervalEnd,
              curve: Curves.easeOut,
            ),
          ),
        );

        final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(
              _descriptionFadeIntervalStart,
              _descriptionFadeIntervalEnd,
              curve: Curves.easeIn,
            ),
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: descriptionLines
            .asMap()
            .entries
            .map(
              (entry) => Text(
            entry.value,
            style: $styles.text.h2.copyWith(
              height: 1.2,
              fontSize: 36,
              color: $styles.colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final greetingAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          _greetingAnimationIntervalStart,
          _greetingAnimationIntervalEnd,
          curve: Curves.linear,
        ),
      ),
    );

    final cardAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          _cardAnimationIntervalStart,
          _cardAnimationIntervalEnd,
          curve: Curves.easeOut,
        ),
      ),
    );


    final countAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          _countAnimationIntervalStart,
          _countAnimationIntervalEnd,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeTransition(
            opacity: greetingAnimation,
            child: Text(
              'Hi, Marina',
              style: $styles.text.h2.copyWith(
                fontSize: 22,
                color: $styles.colors.sandstone500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          _buildDescription(),
          const SizedBox(height: _cardSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatisticsCard(
                title: "BUY",
                count: 1034,
                isSquare: false,
                containerAnimation: cardAnimation,
                countAnimation: countAnimation,
              ),
              _StatisticsCard(
                title: "RENT",
                count: 2212,
                isSquare: true,
                containerAnimation: cardAnimation,
                countAnimation: countAnimation,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  const _StatisticsCard({
    required this.title,
    required this.count,
    required this.isSquare,
    required this.containerAnimation,
    required this.countAnimation,
  });

  final String title;
  final int count;
  final bool isSquare;
  final Animation<double> containerAnimation;
  final Animation<double> countAnimation;

  static const _titlePadding = EdgeInsets.only(top: 16);
  static const _titleFontSize = 16.0;
  static const _countFontSize = 42.0;

  @override
  Widget build(BuildContext context) {
    final color = isSquare ? $styles.colors.sandstone500 : $styles.colors.white;

    return ScaleTransition(
      scale: containerAnimation,
      child: Container(
        height: Info._cardHeight,
        width: $sizeConfig.width * Info._cardWidthFactor,
        decoration: BoxDecoration(
          color: isSquare ? $styles.colors.white : $styles.colors.amber600,
          shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: isSquare ? BorderRadius.circular(Info._cardBorderRadius) : null,
          boxShadow: [
            if (!isSquare)
              BoxShadow(
                color: Colors.black12,
                blurRadius: Info._cardShadowBlurRadius,
                spreadRadius: Info._cardShadowSpreadRadius,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Padding(
              padding: _titlePadding,
              child: Text(
                title,
                style: $styles.text.title2.copyWith(
                  color: color,
                  fontSize: _titleFontSize,
                ),
              ),
            ),
            const Spacer(),
            // Count and "Offers" text
            AnimatedBuilder(
              animation: countAnimation,
              builder: (context, child) {
                final currentCount = (count * countAnimation.value).toInt();
                final formattedCount = currentCount.toString().replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]} ',
                );

                return Column(
                  children: [
                    Text(
                      formattedCount,
                      style: $styles.text.h2.copyWith(
                        color: color,
                        fontSize: _countFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child!,
                  ],
                );
              },
              child: Text(
                "Offers",
                style: $styles.text.title1.copyWith(color: color),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}