import 'package:flutter/material.dart';
import 'package:mon_assessment/core/assets.dart';
import 'package:mon_assessment/main.dart';
import 'package:mon_assessment/presentation/home/widgets/place.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key, required this.animationController});

  final AnimationController animationController;

  static const double _containerPadding = 6.0;
  static const double _topPlaceHeightFactor = 0.22;
  static const double _leftPlaceHeightFactor = 0.4;
  static const double _rightPlaceHeightFactor = 0.195;
  static const double _spacingBetweenPlaces = 10.0;
  static const double _rightColumnSpacingFactor = 0.01;
  static const BorderRadius _containerBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );




  Widget _buildPlace(String title,double heightFactor, double sliderWidth,String image) {
    return Place(
      text: title,
      imgHeight: $sizeConfig.height * heightFactor,
      imgPath: image,
      sliderWidth: sliderWidth,
      animationController: animationController,
    );
  }

  @override
  Widget build(BuildContext context) {

    const rowPlaceWidthFactor = 0.45;

    return Container(
      width: $sizeConfig.width,
      padding: const EdgeInsets.all(_containerPadding),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: $styles.colors.white,
        borderRadius: _containerBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPlace("Gladkova St., 25",_topPlaceHeightFactor, 1.0,ImagePaths.place2),
          const SizedBox(height: _spacingBetweenPlaces),
          Row(
            children: [
              Expanded(
                child: _buildPlace("Malaga St., 92",_leftPlaceHeightFactor, rowPlaceWidthFactor,ImagePaths.place3),
              ),
              const SizedBox(width: _spacingBetweenPlaces),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildPlace("Margaret., 32",_rightPlaceHeightFactor, rowPlaceWidthFactor,ImagePaths.place4),
                    SizedBox(height: $sizeConfig.height * _rightColumnSpacingFactor),
                    _buildPlace("Trefeleva., 43",_rightPlaceHeightFactor, rowPlaceWidthFactor, ImagePaths.place1),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}