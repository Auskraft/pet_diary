import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../logic/active_pet_cubit.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/pet_selector_header.dart';
import '../events/event_detail_screen.dart';
import '../history/history_screen.dart';
import '../reminders/reminders_screen.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final pet = context.watch<ActivePetCubit>().state;
    final recent = kTimeline[0].items.where((e) => e.type != 'medicine').toList();

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen, 8, AppSpacing.screen, 24),
          children: [
            PetSelectorHeader(
              onBell: () => _push(context, const RemindersScreen()),
            ),
            const SizedBox(height: 22),
            Text(AppStrings.s('todayDate', lang),
                style: AppText.caption(color: c.ink3)),
            const SizedBox(height: 12),
            _TodayTask(lang: lang),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    tint: 'sage',
                    icon: 'syringe',
                    label: AppStrings.s('nextVaccine', lang),
                    value: AppStrings.s('inDays', lang),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    tint: 'blue',
                    icon: 'weight',
                    label: AppStrings.s('weight', lang),
                    value: pet.localWeight(lang),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    tint: 'beige',
                    icon: 'stethoscope',
                    label: AppStrings.s('lastVisit', lang),
                    value: lang.pick('7 мая · Осмотр', 'May 7 · Check-up'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    tint: 'peach',
                    icon: 'activity',
                    label: AppStrings.s('activity', lang),
                    value: lang.pick('Хорошая', 'Good'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            SectionTitle(
              AppStrings.s('recent', lang),
              action: AppStrings.s('seeAll', lang),
              onAction: () => _push(context, const HistoryScreen()),
            ),
            const SizedBox(height: 12),
            for (final e in recent) ...[
              EventRow(
                event: e,
                lang: lang,
                showDate: false,
                onTap: () => _push(context, EventDetailScreen(event: e)),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}

class _TodayTask extends StatelessWidget {
  const _TodayTask({required this.lang});
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      color: c.peachSoft,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: Icon(appIcon('pill'), color: c.peachDeep, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.s('todayTasks', lang),
                    style: AppText.tiny(color: c.peachDeep)),
                const SizedBox(height: 3),
                Text(AppStrings.s('giveMed', lang),
                    style: AppText.cardTitle(color: c.ink)),
                const SizedBox(height: 2),
                Text(
                    '${AppStrings.s('todayAt', lang)} · ${AppStrings.s('heptral', lang)}',
                    style: AppText.caption(color: c.ink2)),
              ],
            ),
          ),
          _CheckButton(c: c),
        ],
      ),
    );
  }
}

class _CheckButton extends StatefulWidget {
  const _CheckButton({required this.c});
  final AppColors c;
  @override
  State<_CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<_CheckButton> {
  bool done = false;
  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return GestureDetector(
      onTap: () => setState(() => done = !done),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: done ? c.peach : c.surface,
          shape: BoxShape.circle,
          border: Border.all(color: done ? c.peach : c.line, width: 1.6),
        ),
        child: Icon(appIcon('check'),
            size: 18, color: done ? c.onPeach : c.ink3),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.tint,
    required this.icon,
    required this.label,
    required this.value,
  });
  final String tint, icon, label, value;

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
          Text(label, style: AppText.caption(color: c.ink3)),
          const SizedBox(height: 3),
          Text(value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppText.cardTitle(color: c.ink)),
        ],
      ),
    );
  }
}
