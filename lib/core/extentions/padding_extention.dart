import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/core/extentions/media_query_extention.dart';

extension CustomPadding on BuildContext {
  EdgeInsets verticalPadding(double factor) =>
      EdgeInsets.symmetric(vertical: screenHeight * factor);

  EdgeInsets horizontalPadding(double factor) =>
      EdgeInsets.symmetric(horizontal: screenWidth * factor);

  EdgeInsets paddingAllResponsive(double fraction) =>
      EdgeInsets.all(screenWidth * fraction);

  EdgeInsets paddingOnlyResponsive({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: screenWidth * left,
        top: screenHeight * top,
        right: screenWidth * right,
        bottom: screenHeight * bottom,
      );
}
