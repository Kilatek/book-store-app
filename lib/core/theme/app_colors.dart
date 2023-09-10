import 'package:flutter/material.dart';

class AppColors {
  /// App primary color
  static const Color primary = Color(0xff1DA1F2);

  /// App secondary color
  static const Color error = Color(0xffFC698C);

  /// App black color
  static const Color black = Color(0xff14171A);

  /// App white color
  static const Color white = Color(0xffffffff);

  /// Light grey color
  static const Color lightGrey = Color(0xffAAB8C2);

  /// Extra Light grey color
  static const Color extraLightGrey = Color(0xffE1E8ED);

  static Color get primaryColor2 => black;
  static Color get primaryColor1 => black;

  static Color get secondaryColor1 => black;
  static Color get secondaryColor2 => black;

  static List<Color> get primaryG => [primaryColor1, primaryColor2];
  static List<Color> get secondaryG => [secondaryColor2, secondaryColor1];

  static Color get gray => const Color(0xff786F72);
  static Color get lightGray => const Color(0xffF7F8F8);
}
