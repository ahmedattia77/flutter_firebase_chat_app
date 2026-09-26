import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color gradientStart = Color(0xFF0F2027);
  static const Color gradientMiddle = Color(0xFF203A43);
  static const Color gradientEnd = Color(0xFF2C5364);

  static const Color darkText = Color(0xFF2D3436);

  static const Color white = Colors.white;
  static Color glassBackground = Colors.white.withValues(alpha: 0.06);
  static Color glassBorder = Colors.white.withValues(alpha: 0.1);
  static Color circleOverlay = Colors.white.withValues(alpha: 0.03);
  static Color subTitleText = Colors.white.withValues(alpha: 0.6);
  static Color iconColor = Colors.white.withValues(alpha: 0.9);

  static const Color error = Colors.redAccent;
  static const Color transparent = Colors.transparent;
}
