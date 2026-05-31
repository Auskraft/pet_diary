import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

class FeedingScreen extends StatelessWidget {
  const FeedingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return PageScaffold(
      title: lang.pick('Кормление', 'Feeding'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Row(
              children: [
                SizedBox(
                  width: 76,
                  height: 76,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 76,
                        height: 76,
                        child: CircularProgressIndicator(
                          value: 0.75,
                          strokeWidth: 7,
                          backgroundColor: c.bg2,
                          valueColor:
                              AlwaysStoppedAnimation(c.beigeDeep),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Text('75%', style: AppText.cardTitle(color: c.ink)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang.pick('Съедено сегодня', 'Eaten today'),
                          style: AppText.caption(color: c.ink3)),
                      const SizedBox(height: 4),
                      Text(lang.pick('3 из 4 кормлений', '3 of 4 feedings'),
                          style: AppText.cardTitle(color: c.ink)),
                      const SizedBox(height: 2),
                      Text(lang.pick('120 г · норма 160 г', '120 g · goal 160 g'),
                          style: AppText.caption(color: c.ink2)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SectionTitle(lang.pick('Расписание на сегодня', 'Today’s schedule')),
          const SizedBox(height: 12),
          for (var i = 0; i < kFeeding.length; i++)
            _FeedingRow(item: kFeeding[i], last: i == kFeeding.length - 1, lang: lang),
        ],
      ),
    );
  }
}

class _FeedingRow extends StatelessWidget {
  const _FeedingRow({required this.item, required this.last, required this.lang});
  final FeedingItem item;
  final bool last;
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: c.beige,
                  shape: BoxShape.circle,
                  border: Border.all(color: c.beigeDeep, width: 2),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(width: 2, color: c.line),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AppCard(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(item.emoji, style: const TextStyle(fontSize: 26)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.localTitle(lang),
                              style: AppText.cardTitle(color: c.ink)),
                          const SizedBox(height: 2),
                          Text(item.localSub(lang),
                              style: AppText.caption(color: c.ink3)),
                        ],
                      ),
                    ),
                    Text(item.time, style: AppText.caption(color: c.ink2)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
