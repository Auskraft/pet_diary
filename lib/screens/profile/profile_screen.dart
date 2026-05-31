import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../logic/theme_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../settings/backup_screen.dart';
import '../settings/export_screen.dart';
import '../settings/language_screen.dart';
import '../settings/themes_screen.dart';
import '../showcase/dark_showcase_screen.dart';
import '../showcase/states_screen.dart';
import '../showcase/style_guide_screen.dart';
import '../onboarding/onboarding_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notifications = true;
  bool biometrics = false;

  void _push(Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final mode = context.watch<ThemeCubit>().state;
    final themeLabel = switch (mode) {
      ThemeMode.light => AppStrings.s('themeLight', lang),
      ThemeMode.dark => AppStrings.s('themeDark', lang),
      ThemeMode.system => AppStrings.s('themeSystem', lang),
    };

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen, 12, AppSpacing.screen, 24),
          children: [
            Text(AppStrings.s('profile', lang),
                style: AppText.bigTitle(color: c.ink)),
            const SizedBox(height: 16),
            AppCard(
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: c.peachSoft, shape: BoxShape.circle),
                    child: const Text('🧑', style: TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lang.pick('Анна Соколова', 'Anna Sokolova'),
                            style: AppText.cardTitle(color: c.ink)),
                        const SizedBox(height: 2),
                        Text('anna.sokolova@mail.ru',
                            style: AppText.caption(color: c.ink3)),
                        const SizedBox(height: 2),
                        Text(lang.pick('3 питомца', '3 pets'),
                            style: AppText.caption(color: c.peachDeep)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _Group(children: [
              ListRowTile(
                icon: 'globe',
                iconTint: 'blue',
                title: AppStrings.s('language', lang),
                trailing: _value(lang.title, c),
                onTap: () => _push(const LanguageScreen()),
              ),
              _divider(c),
              ListRowTile(
                icon: 'bell',
                iconTint: 'peach',
                title: AppStrings.s('notifications', lang),
                showChevron: false,
                trailing: AppToggle(
                    value: notifications,
                    onChanged: (v) => setState(() => notifications = v)),
              ),
              _divider(c),
              ListRowTile(
                icon: 'cloud',
                iconTint: 'sage',
                title: AppStrings.s('backup', lang),
                subtitle: AppStrings.s('sync', lang),
                onTap: () => _push(const BackupScreen()),
              ),
            ]),
            const SizedBox(height: 14),
            _Group(children: [
              ListRowTile(
                icon: 'moon',
                iconTint: 'blue',
                title: AppStrings.s('theme', lang),
                trailing: _value(themeLabel, c),
                onTap: () => _push(const ThemesScreen()),
              ),
              _divider(c),
              ListRowTile(
                icon: 'ruler',
                iconTint: 'beige',
                title: AppStrings.s('units', lang),
                trailing: _value(lang.pick('Метрические', 'Metric'), c),
                onTap: () {},
              ),
              _divider(c),
              ListRowTile(
                icon: 'download',
                iconTint: 'peach',
                title: AppStrings.s('export', lang),
                onTap: () => _push(const ExportScreen()),
              ),
            ]),
            const SizedBox(height: 14),
            _Group(children: [
              ListRowTile(
                icon: 'shield',
                iconTint: 'sage',
                title: AppStrings.s('privacy', lang),
                onTap: () {},
              ),
              _divider(c),
              ListRowTile(
                icon: 'faceId',
                iconTint: 'blue',
                title: AppStrings.s('biometry', lang),
                showChevron: false,
                trailing: AppToggle(
                    value: biometrics,
                    onChanged: (v) => setState(() => biometrics = v)),
              ),
            ]),
            const SizedBox(height: 22),
            Text(lang.pick('ДИЗАЙН И ЭКРАНЫ', 'DESIGN & SCREENS'),
                style: AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.6)),
            const SizedBox(height: 10),
            _Group(children: [
              ListRowTile(
                  icon: 'sparkles',
                  iconTint: 'peach',
                  title: lang.pick('Дизайн-система', 'Style guide'),
                  onTap: () => _push(const StyleGuideScreen())),
              _divider(c),
              ListRowTile(
                  icon: 'activity',
                  iconTint: 'blue',
                  title: lang.pick('Состояния экранов', 'Screen states'),
                  onTap: () => _push(const StatesScreen())),
              _divider(c),
              ListRowTile(
                  icon: 'moon',
                  iconTint: 'sage',
                  title: lang.pick('Тёмная витрина', 'Dark showcase'),
                  onTap: () => _push(const DarkShowcaseScreen())),
              _divider(c),
              ListRowTile(
                  icon: 'star',
                  iconTint: 'beige',
                  title: lang.pick('Онбординг', 'Onboarding'),
                  onTap: () => _push(const OnboardingScreen())),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _value(String text, AppColors c) =>
      Text(text, style: AppText.caption(color: c.ink3));

  Widget _divider(AppColors c) => Divider(height: 1, color: c.line, indent: 14, endIndent: 14);
}

class _Group extends StatelessWidget {
  const _Group({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(children: children),
    );
  }
}
