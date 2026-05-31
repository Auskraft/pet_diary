import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_dimens.dart';
import 'core/theme/app_theme.dart';
import 'logic/theme_cubit.dart';
import 'screens/shell/main_shell.dart';

class PetDiaryApp extends StatelessWidget {
  const PetDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    return MaterialApp(
      title: 'Дневник питомца',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      // Soft, organic theme transition.
      builder: (context, child) => AnimatedTheme(
        data: Theme.of(context),
        duration: AppMotion.theme,
        child: child ?? const SizedBox.shrink(),
      ),
      home: const MainShell(),
    );
  }
}
