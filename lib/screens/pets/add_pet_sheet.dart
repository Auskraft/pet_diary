import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_sheet.dart';
import '../../widgets/app_widgets.dart';

Future<void> showAddPetSheet(BuildContext context) {
  return showAppSheet(context, const AddPetSheet());
}

class AddPetSheet extends StatefulWidget {
  const AddPetSheet({super.key});
  @override
  State<AddPetSheet> createState() => _AddPetSheetState();
}

class _AddPetSheetState extends State<AddPetSheet> {
  int species = 0;
  int sex = 0;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SheetHeader(
          title: AppStrings.s('newPet', lang),
          leadingLabel: AppStrings.s('cancel', lang),
          trailingLabel: AppStrings.s('save', lang),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: c.peachSoft,
                        shape: BoxShape.circle,
                      ),
                      child: const Text('🐾',
                          style: TextStyle(fontSize: 36)),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: c.peach,
                          shape: BoxShape.circle,
                          border: Border.all(color: c.bg1, width: 2),
                        ),
                        child: Icon(appIcon('camera'),
                            size: 15, color: c.onPeach),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppField(
                  label: lang.pick('Кличка', 'Name'),
                  value: lang.pick('Например, Мурка', 'e.g. Murka')),
              const SizedBox(height: 16),
              Text(lang.pick('ВИД', 'SPECIES'),
                  style: AppText.tiny(color: c.ink3)
                      .copyWith(letterSpacing: 0.6)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var i = 0; i < kSpeciesOptions.length; i++)
                    AppChip(
                      label: lang.pick(
                          kSpeciesOptions[i][0], kSpeciesOptions[i][1]),
                      selected: species == i,
                      onTap: () => setState(() => species = i),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              AppField(
                  label: lang.pick('Порода', 'Breed'),
                  value: lang.pick('Не указано', 'Not set')),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppField(
                        label: lang.pick('Дата рождения', 'Birth date'),
                        value: '—',
                        onTap: () {}),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lang.pick('ПОЛ', 'SEX'),
                            style: AppText.tiny(color: c.ink3)
                                .copyWith(letterSpacing: 0.6)),
                        const SizedBox(height: 6),
                        AppSegment(
                          options: const ['♀', '♂'],
                          index: sex,
                          onChanged: (i) => setState(() => sex = i),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppField(
                        label: AppStrings.s('weight', lang), value: '—'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppField(
                        label: lang.pick('Окрас', 'Color'), value: '—'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppField(
                  label: lang.pick('Номер чипа', 'Chip number'),
                  value: '—'),
              const SizedBox(height: 16),
              AppField(
                  label: lang.pick('Особенности', 'Traits'),
                  value: lang.pick('Заметки о характере…', 'Notes…')),
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
