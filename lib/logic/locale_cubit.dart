import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/l10n/app_strings.dart';

/// Holds the active [Lang] (ru / en) and persists it.
class LocaleCubit extends Cubit<Lang> {
  LocaleCubit(this._prefs)
      : super(_prefs.getString(_key) == 'en' ? Lang.en : Lang.ru);

  static const _key = 'app_lang';
  final SharedPreferences _prefs;

  void setLang(Lang lang) {
    _prefs.setString(_key, lang.code);
    emit(lang);
  }

  void toggle() => setLang(state == Lang.ru ? Lang.en : Lang.ru);
}

/// Sugar: `context.lang` (reactive) and `context.tr('key')`.
extension LocaleContextX on BuildContext {
  Lang get lang => watch<LocaleCubit>().state;
  Lang get langRead => read<LocaleCubit>().state;
  String tr(String key) => AppStrings.s(key, lang);
}
