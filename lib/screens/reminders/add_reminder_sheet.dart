import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_sheet.dart';
import '../../widgets/app_widgets.dart';

Future<void> showAddReminderSheet(BuildContext context) {
  return showAppSheet(context, const AddReminderSheet());
}

class AddReminderSheet extends StatefulWidget {
  const AddReminderSheet({super.key});
  @override
  State<AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<AddReminderSheet> {
  int repeat = 1;
  bool notify = true;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SheetHeader(
          title: AppStrings.s('reminder', lang),
          leadingLabel: AppStrings.s('cancel', lang),
          trailingLabel: AppStrings.s('done', lang),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              AppField(
                  label: AppStrings.s('title', lang),
                  value: AppStrings.s('giveMed', lang)),
              const SizedBox(height: 16),
              AppField(
                  label: AppStrings.s('description', lang),
                  value: AppStrings.s('heptral', lang)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppField(
                        label: AppStrings.s('date', lang),
                        value: lang.pick('12 мая 2024', 'May 12, 2024'),
                        onTap: () {}),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppField(
                        label: AppStrings.s('time', lang),
                        value: '20:00',
                        onTap: () {}),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(AppStrings.s('repeat', lang).toUpperCase(),
                  style:
                      AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.6)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var i = 0; i < kRepeatOptions.length; i++)
                    AppChip(
                      label:
                          lang.pick(kRepeatOptions[i][0], kRepeatOptions[i][1]),
                      selected: repeat == i,
                      onTap: () => setState(() => repeat = i),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppField(
                        label: AppStrings.s('starts', lang),
                        value: lang.pick('12 мая 2024', 'May 12, 2024'),
                        onTap: () {}),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppField(
                        label: AppStrings.s('ends', lang),
                        value: lang.pick('Не указано', 'Not set'),
                        onTap: () {}),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              AppCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.s('notifications', lang),
                              style: AppText.cardTitle(color: c.ink)),
                          const SizedBox(height: 2),
                          Text(lang.pick('За 15 минут', '15 min before'),
                              style: AppText.caption(color: c.ink3)),
                        ],
                      ),
                    ),
                    AppToggle(
                        value: notify,
                        onChanged: (v) => setState(() => notify = v)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: AppStrings.s('done', lang),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
