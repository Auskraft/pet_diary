import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typographic scale from the handoff.
///
/// Font: SF Pro Rounded on iOS; a rounded fallback (Nunito) elsewhere.
/// We use Nunito via google_fonts with `-apple-system` semantics handled by
/// the platform; pass an explicit [color] from `context.colors`.
abstract class AppText {
  static TextStyle _base(
    double size,
    FontWeight weight, {
    Color? color,
    double height = 1.25,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.nunito(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  /// 23–26 / 800, tracking ≈ −0.5
  static TextStyle bigTitle({Color? color}) =>
      _base(25, FontWeight.w800, color: color, letterSpacing: -0.5, height: 1.15);

  /// 18–20 / 800
  static TextStyle screenTitle({Color? color}) =>
      _base(19, FontWeight.w800, color: color, letterSpacing: -0.3);

  /// 15.5–17 / 800
  static TextStyle section({Color? color}) =>
      _base(16, FontWeight.w800, color: color, letterSpacing: -0.2);

  /// 14.5–15 / 700 — card title / list row
  static TextStyle cardTitle({Color? color}) =>
      _base(15, FontWeight.w700, color: color);

  /// 14–15 / 500–600 — body
  static TextStyle body({Color? color}) =>
      _base(14.5, FontWeight.w500, color: color, height: 1.35);

  static TextStyle bodyStrong({Color? color}) =>
      _base(14.5, FontWeight.w600, color: color, height: 1.35);

  /// 11.5–12.5 / 600–700 — caption / meta (ink3)
  static TextStyle caption({Color? color}) =>
      _base(12, FontWeight.w600, color: color);

  /// 10.5–11 / 700 — tiny labels (nav, tags)
  static TextStyle tiny({Color? color}) =>
      _base(11, FontWeight.w700, color: color, letterSpacing: 0.1);
}
