import 'package:flutter/material.dart';

/// Contains constants for colors used in the app.
///
/// This class is abstract and final, meaning it can't be instantiated
/// or extended. It's a convenient way to group related constants
/// together.
abstract final class AppColors {
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const primary = Color(0xFF2A2B2D);

  static const lightColorScheme = ColorScheme.light();

  static const darkColorScheme = ColorScheme.dark();
}
