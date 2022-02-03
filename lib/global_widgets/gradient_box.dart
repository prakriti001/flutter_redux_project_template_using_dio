import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  final Widget child;

  GradientBox(
      {required this.colors,
      this.begin = Alignment.topLeft,
      this.end = Alignment.bottomRight,
      required this.child});

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[AppColors.themeColor, AppColors.themeColor],
          stops: <double>[0.1, 0.9],
          // Setting gradient rotation value(degrees in radian) to transform the series gradient
          transform: GradientRotation(
            (180 * (3.14 / 180)), // Converted 180 degree to radian
          ),
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}
