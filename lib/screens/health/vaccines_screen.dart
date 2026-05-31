import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/models.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';
import 'health_detail_screen.dart';

/// Records for a Health subcategory. 'vaccines' shows real records; other
/// categories show a calm empty state.
class CategoryRecordsScreen extends StatelessWidget {
  const CategoryRecordsScreen({super.key, required this.category});
  final CategoryTile category;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    final isVaccines = category.id == 'vaccines';

    return PageScaffold(
      title: category.localLabel(lang),
      scroll: isVaccines,
      padded: isVaccines,
      child: isVaccines
          ? _VaccineList(lang: lang)
          : StatePlaceholder(
              title: AppStrings.s('emptyTitle', lang),
              subtitle: AppStrings.s('emptySub', lang),
              primaryLabel: AppStrings.s('addEvent', lang),
              onPrimary: () => Navigator.of(context).maybePop(),
            ),
    );
  }
}

class _VaccineList extends StatelessWidget {
  const _VaccineList({required this.lang});
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final records = <(String, String, String)>[
      (lang.pick('Мультифел-4', 'Multifel-4'),
          lang.pick('20 апреля 2024', 'April 20, 2024'),
          lang.pick('Ветклиника «Лапки»', '«Lapki» Vet Clinic')),
      (lang.pick('Нобивак Tricat', 'Nobivac Tricat'),
          lang.pick('18 апреля 2023', 'April 18, 2023'),
          lang.pick('Ветклиника «Лапки»', '«Lapki» Vet Clinic')),
      (lang.pick('Бешенство', 'Rabies'),
          lang.pick('5 мая 2022', 'May 5, 2022'),
          lang.pick('Ветклиника «Айболит»', '«Aibolit» Vet Clinic')),
    ];

    return Column(
      children: [
        AppCard(
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
                    Text(lang.pick('Следующая прививка', 'Next vaccine'),
                        style: AppText.tiny(color: c.sageDeep)),
                    const SizedBox(height: 3),
                    Text(AppStrings.s('inDays', lang),
                        style: AppText.cardTitle(color: c.ink)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        for (final r in records) ...[
          AppCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HealthDetailScreen(title: r.$1, clinic: r.$3),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                EventIconWell(type: 'vaccine', size: 42),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.$1, style: AppText.cardTitle(color: c.ink)),
                      const SizedBox(height: 2),
                      Text(r.$3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.caption(color: c.ink3)),
                    ],
                  ),
                ),
                Text(r.$2, style: AppText.caption(color: c.ink3)),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
