import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds the app [ThemeMode] (light / dark / system) and persists it.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._prefs) : super(_load(_prefs));

  static const _key = 'app_theme_mode';
  final SharedPreferences _prefs;

  static ThemeMode _load(SharedPreferences p) {
    switch (p.getString(_key)) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void setMode(ThemeMode mode) {
    _prefs.setString(_key, mode.name);
    emit(mode);
  }
}
