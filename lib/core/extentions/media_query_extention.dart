import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => orientation == Orientation.landscape;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}
