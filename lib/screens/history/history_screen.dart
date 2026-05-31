import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../logic/active_pet_cubit.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../events/event_detail_screen.dart';
import '../events/new_event_sheet.dart';
import '../pets/pet_switch_sheet.dart';
import 'search_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String filter = 'all';

  bool _matches(String type) {
    switch (filter) {
      case 'all':
        return true;
      case 'health':
        return ['vaccine', 'visit', 'analysis', 'weight'].contains(type);
      case 'care':
        return ['care', 'grooming', 'walk', 'feeding'].contains(type);
      case 'meds':
        return type == 'medicine';
      case 'photo':
        return type == 'photo';
      case 'note':
        return type == 'note';
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final pet = context.watch<ActivePetCubit>().state;

    return Scaffold(
      backgroundColor: c.bg1,
      floatingActionButton: FloatingActionButton(
        backgroundColor: c.peach,
        elevation: 2,
        onPressed: () => showNewEventSheet(context),
        child: Icon(appIcon('plus'), color: c.onPeach),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, AppSpacing.screen, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child:
                          Icon(appIcon('chevronLeft'), color: c.ink, size: 24),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showPetSwitchSheet(context),
                    child: Row(
                      children: [
                        Text(pet.localName(lang),
                            style: AppText.screenTitle(color: c.ink)),
                        const SizedBox(width: 3),
                        Icon(appIcon('chevronDown'), size: 18, color: c.ink3),
                      ],
                    ),
                  ),
                  const Spacer(),
                  HeaderActionInline(
                    icon: 'search',
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchScreen())),
                  ),
                  const SizedBox(width: 8),
                  const HeaderActionInline(icon: 'filter'),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.screen),
                children: [
                  for (final chip in kFilterChips) ...[
                    AppChip(
                      label: chip.localLabel(lang),
                      selected: filter == chip.id,
                      onTap: () => setState(() => filter = chip.id),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screen, 0, AppSpacing.screen, 96),
                children: [
                  for (final group in kTimeline)
                    ..._buildGroup(group, lang),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGroup(EventMonth group, Lang lang) {
    final c = context.colors;
    final items = group.items.where((e) => _matches(e.type)).toList();
    if (items.isEmpty) return const [];
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 10),
        child: Text(group.localMonth(lang),
            style: AppText.caption(color: c.ink3)),
      ),
      for (final e in items) ...[
        EventRow(
          event: e,
          lang: lang,
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => EventDetailScreen(event: e))),
        ),
        const SizedBox(height: 10),
      ],
    ];
  }
}

/// Small inline header action (avoids importing page_scaffold here).
class HeaderActionInline extends StatelessWidget {
  const HeaderActionInline({super.key, required this.icon, this.onTap});
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: c.bg2, shape: BoxShape.circle),
        child: Icon(appIcon(icon), size: 20, color: c.ink2),
      ),
    );
  }
}
