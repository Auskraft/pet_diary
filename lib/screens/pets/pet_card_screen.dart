import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/active_pet_cubit.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../documents/documents_screen.dart';
import '../history/history_screen.dart';

class PetCardScreen extends StatelessWidget {
  const PetCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final pet = context.watch<ActivePetCubit>().state;

    final fields = <(String, String)>[
      (AppStrings.s('weight', lang), pet.localWeight(lang)),
      (lang.pick('Стерилизация', 'Sterilized'), pet.localSterilized(lang)),
      (lang.pick('Чип', 'Chip'), pet.chip),
      (lang.pick('Аллергии', 'Allergies'), pet.localAllergies(lang)),
      (lang.pick('Особенности', 'Traits'), pet.localTraits(lang)),
      (lang.pick('Хронические', 'Chronic'), pet.localChronic(lang)),
      (lang.pick('Окрас', 'Color'), pet.localColor(lang)),
    ];

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(appIcon('chevronLeft'),
                          color: c.ink, size: 24),
                    ),
                  ),
                  const Spacer(),
                  Icon(appIcon('edit'), color: c.ink2, size: 22),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screen, 8, AppSpacing.screen, 28),
                children: [
                  Center(
                    child: Column(
                      children: [
                        PetAvatar(pet: pet, size: 116),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(pet.localName(lang),
                                style: AppText.bigTitle(color: c.ink)),
                            const SizedBox(width: 6),
                            Text(pet.sexGlyph,
                                style: AppText.screenTitle(color: c.peachDeep)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('${pet.localSpecies(lang)}, ${pet.localBreed(lang)}',
                            textAlign: TextAlign.center,
                            style: AppText.body(color: c.ink2)),
                        const SizedBox(height: 2),
                        Text('${pet.localBorn(lang)} · ${pet.localAge(lang)}',
                            style: AppText.caption(color: c.ink3)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _QuickAction(
                          icon: 'fileText',
                          label: AppStrings.s('passport', lang)),
                      _QuickAction(
                          icon: 'folder',
                          label: AppStrings.s('documents', lang),
                          onTap: () => _push(context, const DocumentsScreen())),
                      _QuickAction(
                          icon: 'clock',
                          label: AppStrings.s('history', lang),
                          onTap: () => _push(context, const HistoryScreen())),
                      _QuickAction(
                          icon: 'notes', label: AppStrings.s('notes', lang)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    child: Column(
                      children: [
                        for (var i = 0; i < fields.length; i++) ...[
                          _FieldRow(
                              label: fields[i].$1, value: fields[i].$2),
                          if (i != fields.length - 1)
                            Divider(height: 1, color: c.line),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, this.onTap});
  final String icon, label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Container(
              height: 56,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(AppRadius.r16),
                boxShadow: c.shadowSoft,
              ),
              child: Icon(appIcon(icon), color: c.peachDeep, size: 22),
            ),
            const SizedBox(height: 6),
            Text(label, style: AppText.tiny(color: c.ink2)),
          ],
        ),
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.body(color: c.ink3)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.right,
                style: AppText.bodyStrong(color: c.ink)),
          ),
        ],
      ),
    );
  }
}
