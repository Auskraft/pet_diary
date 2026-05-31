import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';
import 'feeding_screen.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen, 12, AppSpacing.screen, 24),
          children: [
            Text(AppStrings.s('care', lang),
                style: AppText.bigTitle(color: c.ink)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    tint: 'beige',
                    icon: 'bowl',
                    title: lang.pick('Любимый корм', 'Favorite food'),
                    value: 'Royal Canin British',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    tint: 'sage',
                    icon: 'clock',
                    title: lang.pick('Кормление', 'Feeding'),
                    value: lang.pick('4 раза в день', '4 times a day'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.55,
              children: [
                for (final tile in kCareCats)
                  CategoryTileCard(
                    tile: tile,
                    lang: lang,
                    onTap: () {
                      if (tile.id == 'feeding') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const FeedingScreen()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => _EmptyCategory(title: tile.localLabel(lang))));
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.tint,
    required this.icon,
    required this.title,
    required this.value,
  });
  final String tint, icon, title, value;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconWell(icon: icon, tint: tint, size: 38),
          const SizedBox(height: 12),
          Text(title, style: AppText.caption(color: c.ink3)),
          const SizedBox(height: 3),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.cardTitle(color: c.ink)),
        ],
      ),
    );
  }
}

class _EmptyCategory extends StatelessWidget {
  const _EmptyCategory({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    return PageScaffold(
      title: title,
      scroll: false,
      padded: false,
      child: StatePlaceholder(
        title: AppStrings.s('emptyTitle', lang),
        subtitle: AppStrings.s('emptySub', lang),
        primaryLabel: AppStrings.s('addEvent', lang),
        onPrimary: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}
