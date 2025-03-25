import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_assessment/core/assets.dart';
import 'package:mon_assessment/main.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({super.key});

  static const double _topPositionFactor = 0.08;
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 35);
  static final BorderRadius _borderRadius = BorderRadius.circular(40);
  static const Duration _animationDuration = Duration(milliseconds: 1210);
  static const Duration _animationDelay = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {


    return Positioned(
      top: $sizeConfig.height * _topPositionFactor,
      width: $sizeConfig.width,
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            _buildSearchField(),
            const SizedBox(width: 10),
            _buildFilterButton(),
          ],
        ).animate(delay: _animationDelay).scale(
          duration: _animationDuration,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Flexible(
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: TextFormField(
          controller: TextEditingController(text: 'Saint Petersburg'),
          style:  $styles.text.title1.copyWith(
            color: $styles.colors.obsidian950,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            fillColor: $styles.colors.white,
            filled: true,
            prefixIcon: SvgPicture.asset(
              ImagePaths.mapSearch,
              height: 30,
              width: 45,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 45,
              minHeight: 30,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: $styles.colors.white,
      child: SvgPicture.asset(
        ImagePaths.filter,
        height: 18,
        colorFilter:  ColorFilter.mode(
          $styles.colors.obsidian950,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}