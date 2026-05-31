import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../logic/active_pet_cubit.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_sheet.dart';
import '../../widgets/app_widgets.dart';

Future<void> showPetSwitchSheet(BuildContext context) {
  return showAppSheet(context, const _PetSwitchSheet());
}

class _PetSwitchSheet extends StatelessWidget {
  const _PetSwitchSheet();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final active = context.watch<ActivePetCubit>().state;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SheetHeader(
          title: context.tr('pets'),
          leadingLabel: context.tr('cancel'),
          trailingLabel: '',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            children: [
              for (final pet in kPets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AppCard(
                    onTap: () {
                      context.read<ActivePetCubit>().select(pet);
                      Navigator.of(context).pop();
                    },
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        PetAvatar(pet: pet, size: 48),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(pet.localName(lang),
                                  style: AppText.cardTitle(color: c.ink)),
                              const SizedBox(height: 2),
                              Text(
                                  '${pet.localSpecies(lang)} · ${pet.localAge(lang)}',
                                  style: AppText.caption(color: c.ink3)),
                            ],
                          ),
                        ),
                        if (pet.id == active.id)
                          Icon(appIcon('checkCircle'),
                              color: c.peachDeep, size: 22)
                        else
                          Icon(appIcon('chevronRight'),
                              color: c.ink3, size: 18),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
