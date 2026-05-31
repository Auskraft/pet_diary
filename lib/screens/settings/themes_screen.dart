import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../logic/theme_cubit.dart';
import '../../widgets/page_scaffold.dart';

class ThemesScreen extends StatelessWidget {
  const ThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    final mode = context.watch<ThemeCubit>().state;

    return PageScaffold(
      title: AppStrings.s('themeTitle', lang),
      child: Column(
        children: [
          _ThemeOption(
            label: AppStrings.s('themeLight', lang),
            selected: mode == ThemeMode.light,
            colors: AppColors.light,
            onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.light),
          ),
          const SizedBox(height: 12),
          _ThemeOption(
            label: AppStrings.s('themeDark', lang),
            selected: mode == ThemeMode.dark,
            colors: AppColors.dark,
            onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.dark),
          ),
          const SizedBox(height: 12),
          _ThemeOption(
            label: AppStrings.s('themeSystem', lang),
            selected: mode == ThemeMode.system,
            colors: AppColors.light,
            split: true,
            onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.system),
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.selected,
    required this.colors,
    required this.onTap,
    this.split = false,
  });
  final String label;
  final bool selected;
  final AppColors colors;
  final VoidCallback onTap;
  final bool split;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(AppRadius.r20),
          boxShadow: c.shadowSoft,
          border: Border.all(
              color: selected ? c.peach : c.line,
              width: selected ? 2 : 1),
        ),
        child: Row(
          children: [
            _MiniThumb(colors: colors, split: split),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: AppText.cardTitle(color: c.ink)),
            ),
            Icon(
              appIcon(selected ? 'checkCircle' : 'circle'),
              color: selected ? c.peachDeep : c.line,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniThumb extends StatelessWidget {
  const _MiniThumb({required this.colors, this.split = false});
  final AppColors colors;
  final bool split;

  @override
  Widget build(BuildContext context) {
    Widget frame(AppColors c) => Container(
          color: c.bg1,
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 8,
                width: 26,
                decoration: BoxDecoration(
                  color: c.peach,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: c.shadowSoft,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: c.sageSoft,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: SizedBox(
        width: 58,
        height: 58,
        child: split
            ? Row(
                children: [
                  Expanded(child: frame(AppColors.light)),
                  Expanded(child: frame(AppColors.dark)),
                ],
              )
            : frame(colors),
      ),
    );
  }
}
