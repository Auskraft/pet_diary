import 'package:flutter/material.dart';

/// Canonical design tokens from the «Дневник питомца» hi-fi handoff.
/// Exposed as a [ThemeExtension] so widgets read tokens via `context.colors`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  // Surfaces / backgrounds
  final Color bg0; // primary background (warm off-white)
  final Color bg1; // page background
  final Color bg2; // inset fields / chips / icon wells
  final Color surface; // cards
  final Color surface2; // subtle alt surface

  // Text
  final Color ink; // primary text
  final Color ink2; // secondary (warm gray)
  final Color ink3; // tertiary / captions / placeholders
  final Color line; // borders / dividers

  // Accents — peach (primary)
  final Color peach;
  final Color peachDeep;
  final Color peachSoft;
  final Color onPeach; // text/icon on a filled peach button

  // Accents — sage (health)
  final Color sage;
  final Color sageDeep;
  final Color sageSoft;

  // Accents — dusty blue (measurements / visits)
  final Color blue;
  final Color blueDeep;
  final Color blueSoft;

  // Accents — warm beige (care / feeding)
  final Color beige;
  final Color beigeDeep;
  final Color beigeSoft;

  // Shadows
  final List<BoxShadow> shadowSoft;
  final List<BoxShadow> shadowMedium;
  final List<BoxShadow> shadowUp;

  const AppColors({
    required this.bg0,
    required this.bg1,
    required this.bg2,
    required this.surface,
    required this.surface2,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.line,
    required this.peach,
    required this.peachDeep,
    required this.peachSoft,
    required this.onPeach,
    required this.sage,
    required this.sageDeep,
    required this.sageSoft,
    required this.blue,
    required this.blueDeep,
    required this.blueSoft,
    required this.beige,
    required this.beigeDeep,
    required this.beigeSoft,
    required this.shadowSoft,
    required this.shadowMedium,
    required this.shadowUp,
  });

  /// Base accent colour by tint name used in mock data ('peach'|'sage'|'blue'|'beige').
  Color tintBase(String t) => switch (t) {
        'peach' => peach,
        'sage' => sage,
        'blue' => blue,
        'beige' => beige,
        _ => peach,
      };

  /// Deep (icon/text) accent colour by tint name.
  Color tintDeep(String t) => switch (t) {
        'peach' => peachDeep,
        'sage' => sageDeep,
        'blue' => blueDeep,
        'beige' => beigeDeep,
        _ => peachDeep,
      };

  /// Soft (tinted background) colour by tint name.
  Color tintSoft(String t) => switch (t) {
        'peach' => peachSoft,
        'sage' => sageSoft,
        'blue' => blueSoft,
        'beige' => beigeSoft,
        _ => peachSoft,
      };

  static const light = AppColors(
    bg0: Color(0xFFFFFDF9),
    bg1: Color(0xFFFAF7F2),
    bg2: Color(0xFFF7F4EE),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFFBF8F3),
    ink: Color(0xFF2B2B2B),
    ink2: Color(0xFF6E675F),
    ink3: Color(0xFFA49C92),
    line: Color(0xFFEFE8DE),
    peach: Color(0xFFF4B8A8),
    peachDeep: Color(0xFFD88A73),
    peachSoft: Color(0xFFFCEDE7),
    onPeach: Color(0xFF5A3325),
    sage: Color(0xFFB7C8B5),
    sageDeep: Color(0xFF7E9A7B),
    sageSoft: Color(0xFFEBF1EA),
    blue: Color(0xFFAFC6D9),
    blueDeep: Color(0xFF6E97B4),
    blueSoft: Color(0xFFE9F0F5),
    beige: Color(0xFFE8D8C8),
    beigeDeep: Color(0xFFB08E6E),
    beigeSoft: Color(0xFFF6EFE7),
    shadowSoft: [
      BoxShadow(color: Color(0x0A785A3C), offset: Offset(0, 1), blurRadius: 2),
      BoxShadow(color: Color(0x0F785A3C), offset: Offset(0, 4), blurRadius: 14),
    ],
    shadowMedium: [
      BoxShadow(color: Color(0x1F785A3C), offset: Offset(0, 8), blurRadius: 28),
    ],
    shadowUp: [
      BoxShadow(color: Color(0x14785A3C), offset: Offset(0, -6), blurRadius: 24),
    ],
  );

  static const dark = AppColors(
    bg0: Color(0xFF1F1F1F),
    bg1: Color(0xFF1A1A1A),
    bg2: Color(0xFF252525),
    surface: Color(0xFF2B2B2B),
    surface2: Color(0xFF252525),
    ink: Color(0xFFF2EDE6),
    ink2: Color(0xFFB6AEA4),
    ink3: Color(0xFF807A71),
    line: Color(0xFF383634),
    peach: Color(0xFFF4B8A8),
    peachDeep: Color(0xFFF4B8A8),
    peachSoft: Color(0xFF3A2A24),
    onPeach: Color(0xFF3A1F15),
    sage: Color(0xFFB7C8B5),
    sageDeep: Color(0xFFB7C8B5),
    sageSoft: Color(0xFF263028),
    blue: Color(0xFFAFC6D9),
    blueDeep: Color(0xFFAFC6D9),
    blueSoft: Color(0xFF222E36),
    beige: Color(0xFFE8D8C8),
    beigeDeep: Color(0xFFE8D8C8),
    beigeSoft: Color(0xFF322B24),
    shadowSoft: [
      BoxShadow(color: Color(0x40000000), offset: Offset(0, 1), blurRadius: 2),
      BoxShadow(color: Color(0x4D000000), offset: Offset(0, 4), blurRadius: 14),
    ],
    shadowMedium: [
      BoxShadow(color: Color(0x73000000), offset: Offset(0, 8), blurRadius: 28),
    ],
    shadowUp: [
      BoxShadow(color: Color(0x59000000), offset: Offset(0, -6), blurRadius: 24),
    ],
  );

  @override
  AppColors copyWith({
    Color? bg0,
    Color? bg1,
    Color? bg2,
    Color? surface,
    Color? surface2,
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? line,
    Color? peach,
    Color? peachDeep,
    Color? peachSoft,
    Color? onPeach,
    Color? sage,
    Color? sageDeep,
    Color? sageSoft,
    Color? blue,
    Color? blueDeep,
    Color? blueSoft,
    Color? beige,
    Color? beigeDeep,
    Color? beigeSoft,
    List<BoxShadow>? shadowSoft,
    List<BoxShadow>? shadowMedium,
    List<BoxShadow>? shadowUp,
  }) {
    return AppColors(
      bg0: bg0 ?? this.bg0,
      bg1: bg1 ?? this.bg1,
      bg2: bg2 ?? this.bg2,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      ink3: ink3 ?? this.ink3,
      line: line ?? this.line,
      peach: peach ?? this.peach,
      peachDeep: peachDeep ?? this.peachDeep,
      peachSoft: peachSoft ?? this.peachSoft,
      onPeach: onPeach ?? this.onPeach,
      sage: sage ?? this.sage,
      sageDeep: sageDeep ?? this.sageDeep,
      sageSoft: sageSoft ?? this.sageSoft,
      blue: blue ?? this.blue,
      blueDeep: blueDeep ?? this.blueDeep,
      blueSoft: blueSoft ?? this.blueSoft,
      beige: beige ?? this.beige,
      beigeDeep: beigeDeep ?? this.beigeDeep,
      beigeSoft: beigeSoft ?? this.beigeSoft,
      shadowSoft: shadowSoft ?? this.shadowSoft,
      shadowMedium: shadowMedium ?? this.shadowMedium,
      shadowUp: shadowUp ?? this.shadowUp,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      bg0: Color.lerp(bg0, other.bg0, t)!,
      bg1: Color.lerp(bg1, other.bg1, t)!,
      bg2: Color.lerp(bg2, other.bg2, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      ink3: Color.lerp(ink3, other.ink3, t)!,
      line: Color.lerp(line, other.line, t)!,
      peach: Color.lerp(peach, other.peach, t)!,
      peachDeep: Color.lerp(peachDeep, other.peachDeep, t)!,
      peachSoft: Color.lerp(peachSoft, other.peachSoft, t)!,
      onPeach: Color.lerp(onPeach, other.onPeach, t)!,
      sage: Color.lerp(sage, other.sage, t)!,
      sageDeep: Color.lerp(sageDeep, other.sageDeep, t)!,
      sageSoft: Color.lerp(sageSoft, other.sageSoft, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      blueDeep: Color.lerp(blueDeep, other.blueDeep, t)!,
      blueSoft: Color.lerp(blueSoft, other.blueSoft, t)!,
      beige: Color.lerp(beige, other.beige, t)!,
      beigeDeep: Color.lerp(beigeDeep, other.beigeDeep, t)!,
      beigeSoft: Color.lerp(beigeSoft, other.beigeSoft, t)!,
      shadowSoft: t < 0.5 ? shadowSoft : other.shadowSoft,
      shadowMedium: t < 0.5 ? shadowMedium : other.shadowMedium,
      shadowUp: t < 0.5 ? shadowUp : other.shadowUp,
    );
  }
}

/// Convenience accessor: `context.colors.peach`.
extension AppColorsX on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}
