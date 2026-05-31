import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/app_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../logic/active_pet_cubit.dart';
import '../logic/locale_cubit.dart';
import '../screens/pets/pet_switch_sheet.dart';
import 'app_widgets.dart';

/// Header with the active-pet selector (avatar + name + age + chevron) and a
/// bell button. Used on Overview and History.
class PetSelectorHeader extends StatelessWidget {
  const PetSelectorHeader({super.key, this.onBell});
  final VoidCallback? onBell;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final pet = context.watch<ActivePetCubit>().state;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => showPetSwitchSheet(context),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                PetAvatar(pet: pet, size: 46),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(pet.localName(lang),
                                overflow: TextOverflow.ellipsis,
                                style: AppText.screenTitle(color: c.ink)),
                          ),
                          const SizedBox(width: 4),
                          Icon(appIcon('chevronDown'),
                              size: 18, color: c.ink3),
                        ],
                      ),
                      Text(pet.localAge(lang),
                          style: AppText.caption(color: c.ink3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        AppIconButton(
          icon: appIcon('bell'),
          onTap: onBell ?? () {},
          badge: true,
        ),
      ],
    );
  }
}
