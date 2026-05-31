import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import 'vaccines_screen.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

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
            Text(AppStrings.s('health', lang),
                style: AppText.bigTitle(color: c.ink)),
            const SizedBox(height: 16),
            _NextVaccineBanner(lang: lang),
            const SizedBox(height: 18),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.55,
              children: [
                for (final tile in kHealthCats)
                  CategoryTileCard(
                    tile: tile,
                    lang: lang,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => CategoryRecordsScreen(category: tile)),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NextVaccineBanner extends StatelessWidget {
  const _NextVaccineBanner({required this.lang});
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      color: c.sageSoft,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: Icon(appIcon('syringe'), color: c.sageDeep, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.s('nextVaccine', lang),
                    style: AppText.tiny(color: c.sageDeep)),
                const SizedBox(height: 3),
                Text(lang.pick('Мультифел-4', 'Multifel-4'),
                    style: AppText.cardTitle(color: c.ink)),
                Text(AppStrings.s('inDays', lang),
                    style: AppText.caption(color: c.ink2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
