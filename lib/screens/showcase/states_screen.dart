import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

class StatesScreen extends StatefulWidget {
  const StatesScreen({super.key});
  @override
  State<StatesScreen> createState() => _StatesScreenState();
}

class _StatesScreenState extends State<StatesScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final tabs = [
      lang.pick('Пусто', 'Empty'),
      lang.pick('Загрузка', 'Loading'),
      lang.pick('Ошибка', 'Error'),
      lang.pick('Офлайн', 'Offline'),
    ];

    return PageScaffold(
      title: lang.pick('Состояния экранов', 'Screen states'),
      scroll: false,
      child: Column(
        children: [
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i < tabs.length; i++) ...[
                  AppChip(
                    label: tabs[i],
                    selected: index == i,
                    onTap: () => setState(() => index = i),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          Expanded(child: _content(c, lang)),
        ],
      ),
    );
  }

  Widget _content(AppColors c, lang) {
    switch (index) {
      case 1:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: c.peachSoft, shape: BoxShape.circle),
                child: const Text('🐾', style: TextStyle(fontSize: 40)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(
                    strokeWidth: 2.6, color: c.peachDeep),
              ),
              const SizedBox(height: 16),
              Text(AppStrings.s('loadingTitle', lang),
                  style: TextStyle(
                      color: c.ink, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 6),
              Text(AppStrings.s('loadingSub', lang),
                  style: TextStyle(color: c.ink2)),
            ],
          ),
        );
      case 2:
        return StatePlaceholder(
          emoji: '🙀',
          title: AppStrings.s('errorTitle', lang),
          subtitle: AppStrings.s('errorSub', lang),
          primaryLabel: AppStrings.s('retry', lang),
          onPrimary: () {},
          secondaryLabel: AppStrings.s('back', lang),
          onSecondary: () => Navigator.of(context).maybePop(),
        );
      case 3:
        return StatePlaceholder(
          iconWidget: Icon(appIcon('wifiOff'), size: 44, color: c.peachDeep),
          title: AppStrings.s('offlineTitle', lang),
          subtitle: AppStrings.s('offlineSub', lang),
          primaryLabel: AppStrings.s('retry2', lang),
          onPrimary: () {},
          secondaryLabel: AppStrings.s('offlineMode', lang),
          onSecondary: () {},
        );
      default:
        return StatePlaceholder(
          emoji: '🐶',
          title: AppStrings.s('emptyTitle', lang),
          subtitle: AppStrings.s('emptySub', lang),
          primaryLabel: AppStrings.s('addEvent', lang),
          onPrimary: () {},
        );
    }
  }
}
