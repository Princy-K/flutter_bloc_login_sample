import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/core/extentions/media_query_extention.dart';

extension SizedBoxExtension on BuildContext {
  SizedBox spaceH(double fraction) => SizedBox(height: screenHeight * fraction);

  SizedBox spaceW(double fraction) => SizedBox(width: screenWidth * fraction);
}
