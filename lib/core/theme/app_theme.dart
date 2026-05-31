import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds the light & dark [ThemeData] for «Дневник питомца».
abstract class AppTheme {
  static ThemeData light() => _build(AppColors.light, Brightness.light);
  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors c, Brightness brightness) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    final textTheme = GoogleFonts.nunitoTextTheme(base.textTheme).apply(
      bodyColor: c.ink,
      displayColor: c.ink,
    );

    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: c.bg1,
      canvasColor: c.bg1,
      textTheme: textTheme,
      splashColor: c.peach.withValues(alpha: 0.12),
      highlightColor: c.peach.withValues(alpha: 0.06),
      dividerColor: c.line,
      colorScheme: ColorScheme.fromSeed(
        seedColor: c.peach,
        brightness: brightness,
        primary: c.peach,
        onPrimary: c.onPeach,
        surface: c.surface,
        onSurface: c.ink,
      ),
      extensions: <ThemeExtension<dynamic>>[c],
    );
  }
}
