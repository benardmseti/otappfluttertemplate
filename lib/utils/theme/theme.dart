import 'package:flutter/material.dart';
import 'package:otappfluttertemplate/utils/theme/colors.dart';

/// Defines two static themes for a flutter app [lightTheme] and [darkTheme]
abstract final class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
  );
}
