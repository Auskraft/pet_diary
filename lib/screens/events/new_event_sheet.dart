import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_sheet.dart';
import '../../widgets/app_widgets.dart';

Future<void> showNewEventSheet(BuildContext context) {
  return showAppSheet(context, const NewEventSheet());
}

class NewEventSheet extends StatefulWidget {
  const NewEventSheet({super.key});
  @override
  State<NewEventSheet> createState() => _NewEventSheetState();
}

class _NewEventSheetState extends State<NewEventSheet> {
  String type = 'visit';

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SheetHeader(
          title: AppStrings.s('newEvent', lang),
          leadingLabel: AppStrings.s('cancel', lang),
          trailingLabel: AppStrings.s('save', lang),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in kQuickEventTypes)
                    AppChip(
                      label: eventMeta(t).localLabel(lang),
                      icon: eventMeta(t).icon,
                      selected: type == t,
                      onTap: () => setState(() => type = t),
                    ),
                ],
              ),
              const SizedBox(height: 18),
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
                        value: '10:30',
                        onTap: () {}),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppField(
                  label: AppStrings.s('title', lang),
                  value: AppStrings.s('routine', lang)),
              const SizedBox(height: 16),
              AppField(
                label: AppStrings.s('description', lang),
                child: Text(
                  lang.pick('Проверка общего состояния, вес, температура',
                      'General check, weight, temperature'),
                  style: AppText.body(color: c.ink2),
                ),
              ),
              const SizedBox(height: 16),
              AppField(
                  label: AppStrings.s('reminder', lang),
                  value: AppStrings.s('notSet', lang),
                  onTap: () {}),
              const SizedBox(height: 16),
              Text(AppStrings.s('tags', lang).toUpperCase(),
                  style:
                      AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.6)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppTag(lang.pick('Осмотр', 'Check-up'), tint: 'blue'),
                  AppTag(lang.pick('Визит', 'Visit'), tint: 'sage'),
                  DashedBorder(
                    color: c.line,
                    radius: AppRadius.pill,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: _AddTag(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(AppStrings.s('files', lang).toUpperCase(),
                  style:
                      AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.6)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _FileThumb(emoji: '🐱', c: c),
                  const SizedBox(width: 10),
                  DashedBorder(
                    color: c.line,
                    radius: AppRadius.r16,
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: Icon(appIcon('plus'), color: c.ink3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppButton(
                label: AppStrings.s('save', lang),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AddTag extends StatelessWidget {
  const _AddTag();
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(appIcon('plus'), size: 13, color: c.ink3),
        const SizedBox(width: 4),
        Text(context.lang.pick('Тег', 'Tag'),
            style: AppText.tiny(color: c.ink3)),
      ],
    );
  }
}

class _FileThumb extends StatelessWidget {
  const _FileThumb({required this.emoji, required this.c});
  final String emoji;
  final AppColors c;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.blueSoft,
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 30)),
    );
  }
}
