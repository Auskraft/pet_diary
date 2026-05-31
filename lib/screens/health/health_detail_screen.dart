import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

class HealthDetailScreen extends StatelessWidget {
  const HealthDetailScreen({
    super.key,
    required this.title,
    required this.clinic,
  });
  final String title;
  final String clinic;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    final fields = <(String, String)>[
      (lang.pick('Тип', 'Type'), lang.pick('Прививка', 'Vaccine')),
      (lang.pick('Препарат', 'Drug'), title),
      (lang.pick('Дозировка', 'Dose'), lang.pick('1 мл, п/к', '1 ml, s/c')),
      (lang.pick('Результат', 'Result'), lang.pick('Без реакций', 'No reactions')),
      (lang.pick('Клиника', 'Clinic'), clinic),
    ];

    return PageScaffold(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                EventIconWell(type: 'vaccine', size: 64),
                const SizedBox(height: 10),
                AppTag(lang.pick('Прививка', 'Vaccine'), tint: 'sage'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                for (var i = 0; i < fields.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Row(
                      children: [
                        Text(fields[i].$1,
                            style: AppText.body(color: c.ink3)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(fields[i].$2,
                              textAlign: TextAlign.right,
                              style: AppText.bodyStrong(color: c.ink)),
                        ),
                      ],
                    ),
                  ),
                  if (i != fields.length - 1)
                    Divider(height: 1, color: c.line),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          SectionTitle(AppStrings.s('description', lang)),
          const SizedBox(height: 10),
          AppCard(
            child: Text(
              lang.pick(
                'Плановая ежегодная вакцинация. Питомец перенёс процедуру спокойно, аппетит в норме.',
                'Routine annual vaccination. The pet tolerated the procedure calmly, appetite is normal.',
              ),
              style: AppText.body(color: c.ink2),
            ),
          ),
          const SizedBox(height: 18),
          AppCard(
            color: c.peachSoft,
            child: Row(
              children: [
                Icon(appIcon('bellRing'), color: c.peachDeep, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang.pick('Следующее действие', 'Next action'),
                          style: AppText.tiny(color: c.peachDeep)),
                      const SizedBox(height: 2),
                      Text(
                          lang.pick('Ревакцинация · 30 мая',
                              'Booster · May 30'),
                          style: AppText.cardTitle(color: c.ink)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
