import 'package:flutter/material.dart';

/// 8pt-grid spacing steps from the handoff.
abstract class AppSpacing {
  static const double x4 = 4;
  static const double x8 = 8;
  static const double x12 = 12;
  static const double x16 = 16;
  static const double x24 = 24;
  static const double x32 = 32;

  /// Default horizontal screen padding (~20px).
  static const double screen = 20;
}

/// Corner radii (12 / 16 / 20 / 24 / 28). Cards usually 24.
abstract class AppRadius {
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r20 = 20;
  static const double r24 = 24;
  static const double r28 = 28;
  static const double pill = 999;

  static const BorderRadius card = BorderRadius.all(Radius.circular(r24));
  static const BorderRadius field = BorderRadius.all(Radius.circular(r16));
  static const BorderRadius well = BorderRadius.all(Radius.circular(r12));
  static const BorderRadius sheet =
      BorderRadius.vertical(top: Radius.circular(r28));
}

/// Animation timings from the handoff.
abstract class AppMotion {
  static const Duration theme = Duration(milliseconds: 450);
  static const Duration sheet = Duration(milliseconds: 420);
  static const Duration fade = Duration(milliseconds: 350);
  static const Cubic sheetCurve = Cubic(0.22, 1, 0.36, 1);
}
