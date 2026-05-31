import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});
  final PetEvent event;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final meta = eventMeta(event.type);

    return PageScaffold(
      title: meta.localLabel(lang),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                EventIconWell(type: event.type, size: 64),
                const SizedBox(height: 12),
                Text(event.localTitle(lang),
                    style: AppText.screenTitle(color: c.ink)),
                const SizedBox(height: 4),
                Text(
                    '${event.day} ${event.localMon(lang)} · ${event.time}',
                    style: AppText.caption(color: c.ink3)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SectionTitle(AppStrings.s('description', lang)),
          const SizedBox(height: 10),
          AppCard(
            child: Text(event.localSub(lang),
                style: AppText.body(color: c.ink2)),
          ),
          const SizedBox(height: 18),
          SectionTitle(AppStrings.s('files', lang)),
          const SizedBox(height: 10),
          Row(
            children: [
              _Thumb(color: c.blueSoft, emoji: '🐱'),
              const SizedBox(width: 10),
              _Thumb(color: c.peachSoft, icon: 'fileText'),
            ],
          ),
          const SizedBox(height: 18),
          SectionTitle(AppStrings.s('tags', lang)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final t in event.tags) AppTag(t, tint: meta.tint),
            ],
          ),
          const SizedBox(height: 18),
          AppCard(
            color: c.peachSoft,
            child: Row(
              children: [
                Icon(appIcon('bellRing'), color: c.peachDeep, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    lang.pick('Напоминание установлено · за 15 минут',
                        'Reminder set · 15 min before'),
                    style: AppText.bodyStrong(color: c.ink),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: AppStrings.s('edit', lang),
                  variant: AppButtonVariant.secondary,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  label: AppStrings.s('delete', lang),
                  variant: AppButtonVariant.secondary,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.color, this.emoji, this.icon});
  final Color color;
  final String? emoji;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: 72,
      height: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: emoji != null
          ? Text(emoji!, style: const TextStyle(fontSize: 32))
          : Icon(appIcon(icon!), color: c.peachDeep, size: 26),
    );
  }
}
