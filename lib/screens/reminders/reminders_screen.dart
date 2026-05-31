import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';
import 'add_reminder_sheet.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final active = kReminders.where((r) => !r.done).toList();
    final done = kReminders.where((r) => r.done).toList();

    return PageScaffold(
      title: AppStrings.s('reminders', lang),
      actions: [
        GestureDetector(
          onTap: () => showAddReminderSheet(context),
          child: Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: c.peach, shape: BoxShape.circle),
            child: Icon(appIcon('plus'), color: c.onPeach, size: 20),
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.s('active', lang),
              style: AppText.caption(color: c.ink3)),
          const SizedBox(height: 10),
          for (final r in active) ...[
            _ReminderCard(reminder: r, lang: lang),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          Text(AppStrings.s('completed', lang),
              style: AppText.caption(color: c.ink3)),
          const SizedBox(height: 10),
          for (final r in done) ...[
            _ReminderCard(reminder: r, lang: lang),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.reminder, required this.lang});
  final Reminder reminder;
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final critical = reminder.state == ReminderState.critical;
    final snooze = reminder.state == ReminderState.snooze;
    final done = reminder.done;

    final cardColor = critical
        ? c.peachSoft
        : snooze
            ? c.blueSoft
            : c.surface;

    return AppCard(
      color: cardColor,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            children: [
              _Checkbox(done: done, c: c),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            reminder.localTitle(lang),
                            style: AppText.cardTitle(color: c.ink).copyWith(
                              decoration: done
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: done ? c.ink3 : c.ink,
                            ),
                          ),
                        ),
                        if (critical) ...[
                          const SizedBox(width: 8),
                          AppTag(AppStrings.s('today', lang), tint: 'peach'),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('${reminder.localTime(lang)} · ${reminder.localRepeat(lang)}',
                        style: AppText.caption(color: c.ink3)),
                  ],
                ),
              ),
              if (critical)
                Icon(appIcon('bellRing'), color: c.peachDeep, size: 20)
              else if (snooze)
                Icon(appIcon('clock'), color: c.blueDeep, size: 20),
            ],
          ),
          if (critical) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: AppStrings.s('complete', lang),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    label: AppStrings.s('snoozeLater', lang),
                    variant: AppButtonVariant.secondary,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.done, required this.c});
  final bool done;
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: done ? c.peach : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: done ? c.peach : c.line, width: 1.8),
      ),
      child: done
          ? Icon(appIcon('check'), size: 16, color: c.onPeach)
          : null,
    );
  }
}
