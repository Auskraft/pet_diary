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
import 'add_pet_sheet.dart';
import 'pet_card_screen.dart';

class PetsListScreen extends StatelessWidget {
  const PetsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen, 12, AppSpacing.screen, 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.s('pets', lang),
                    style: AppText.bigTitle(color: c.ink)),
                GestureDetector(
                  onTap: () => showAddPetSheet(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: c.peach, shape: BoxShape.circle),
                    child:
                        Icon(appIcon('plus'), color: c.onPeach, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            for (final pet in kPets) ...[
              AppCard(
                onTap: () {
                  context.read<ActivePetCubit>().select(pet);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PetCardScreen()),
                  );
                },
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    PetAvatar(pet: pet, size: 56),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(pet.localName(lang),
                                  style: AppText.cardTitle(color: c.ink)),
                              const SizedBox(width: 4),
                              Text(pet.sexGlyph,
                                  style: AppText.caption(color: c.ink3)),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                              '${pet.localSpecies(lang)}, ${pet.localBreed(lang)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.caption(color: c.ink3)),
                          Text(pet.localAge(lang),
                              style: AppText.caption(color: c.ink3)),
                        ],
                      ),
                    ),
                    Icon(appIcon('chevronRight'), color: c.ink3, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 4),
            AppButton(
              label: '+ ${AppStrings.s('addPet', lang)}',
              variant: AppButtonVariant.dashed,
              onPressed: () => showAddPetSheet(context),
            ),
          ],
        ),
      ),
    );
  }
}
