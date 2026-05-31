import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return PageScaffold(
      title: AppStrings.s('language', lang),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Group(children: [
            for (final l in Lang.values) ...[
              ListRowTile(
                title: l.title,
                showChevron: false,
                trailing: l == lang
                    ? Icon(appIcon('checkCircle'),
                        color: c.peachDeep, size: 22)
                    : const SizedBox(width: 22),
                onTap: () => context.read<LocaleCubit>().setLang(l),
              ),
              if (l != Lang.values.last)
                Divider(height: 1, color: c.line, indent: 14, endIndent: 14),
            ],
          ]),
          const SizedBox(height: 24),
          Text(lang.pick('ОДИН ЭКРАН — ДВА ЯЗЫКА', 'ONE SCREEN — TWO LANGUAGES'),
              style: AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.6)),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _MiniOverview(lang: Lang.ru)),
              const SizedBox(width: 12),
              Expanded(child: _MiniOverview(lang: Lang.en)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniOverview extends StatelessWidget {
  const _MiniOverview({required this.lang});
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lang.code.toUpperCase(),
              style: AppText.tiny(color: c.peachDeep)),
          const SizedBox(height: 8),
          Text(AppStrings.s('todayDate', lang),
              style: AppText.caption(color: c.ink3)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: c.peachSoft,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.s('giveMed', lang),
                    style: AppText.caption(color: c.ink)),
                Text(AppStrings.s('heptral', lang),
                    style: AppText.tiny(color: c.ink2)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('${AppStrings.s('weight', lang)} · ${lang.pick('4,2 кг', '4.2 kg')}',
              style: AppText.caption(color: c.ink2)),
          const SizedBox(height: 6),
          Text(AppStrings.s('emptyTitle', lang),
              style: AppText.caption(color: c.ink3)),
        ],
      ),
    );
  }
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
