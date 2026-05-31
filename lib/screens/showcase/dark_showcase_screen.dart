import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/page_scaffold.dart';

/// A grid of mini frames rendered with the dark palette to prove coverage,
/// regardless of the app's current theme.
class DarkShowcaseScreen extends StatelessWidget {
  const DarkShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    final d = AppColors.dark;
    final frames = <(String, Widget)>[
      (lang.pick('Обзор', 'Overview'), _overview(d, lang)),
      (lang.pick('Карточка', 'Pet card'), _petCard(d, lang)),
      (lang.pick('Таймлайн', 'Timeline'), _timeline(d, lang)),
      (lang.pick('Событие', 'Event'), _event(d, lang)),
    ];

    return PageScaffold(
      title: lang.pick('Тёмная витрина', 'Dark showcase'),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.62,
        children: [
          for (final f in frames)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.r24),
                    child: Container(color: d.bg1, child: f.$2),
                  ),
                ),
                const SizedBox(height: 8),
                Text(f.$1,
                    style: AppText.caption(color: context.colors.ink3)),
              ],
            ),
        ],
      ),
    );
  }

  static Widget _bar(AppColors d, Color tint) => Container(
        height: 30,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static Widget _overview(AppColors d, lang) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 14,
                    backgroundColor: d.peachSoft,
                    child: const Text('🐱', style: TextStyle(fontSize: 14))),
                const SizedBox(width: 8),
                Container(
                    width: 60,
                    height: 10,
                    decoration: BoxDecoration(
                        color: d.surface,
                        borderRadius: BorderRadius.circular(4))),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 44,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  color: d.peachSoft,
                  borderRadius: BorderRadius.circular(12)),
            ),
            Row(children: [
              Expanded(child: _bar(d, d.sageSoft)),
              const SizedBox(width: 8),
              Expanded(child: _bar(d, d.blueSoft)),
            ]),
            _bar(d, d.surface),
            _bar(d, d.surface),
          ],
        ),
      );

  static Widget _petCard(AppColors d, lang) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 6),
            CircleAvatar(
                radius: 26,
                backgroundColor: d.peachSoft,
                child: const Text('🐱', style: TextStyle(fontSize: 26))),
            const SizedBox(height: 10),
            Container(
                width: 50,
                height: 10,
                decoration: BoxDecoration(
                    color: d.surface,
                    borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 14),
            _bar(d, d.surface),
            _bar(d, d.surface),
            _bar(d, d.surface),
          ],
        ),
      );

  static Widget _timeline(AppColors d, lang) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 40,
                height: 8,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: d.ink3,
                    borderRadius: BorderRadius.circular(4))),
            for (final t in [d.sage, d.peach, d.blue, d.beige])
              Container(
                height: 34,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: d.surface,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const SizedBox(width: 8),
                  Container(
                      width: 22,
                      height: 22,
                      decoration:
                          BoxDecoration(color: t.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(7))),
                ]),
              ),
          ],
        ),
      );

  static Widget _event(AppColors d, lang) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: d.peachSoft,
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(appIcon('pill'), color: d.peachDeep, size: 20)),
            const SizedBox(height: 12),
            _bar(d, d.surface),
            const SizedBox(height: 4),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: d.surface,
                  borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(height: 8),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: d.peachSoft,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      );
}
