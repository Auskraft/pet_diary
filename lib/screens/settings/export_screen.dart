import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});
  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  late List<bool> selected;
  int format = 0; // 0 pdf, 1 text

  @override
  void initState() {
    super.initState();
    selected = List<bool>.filled(7, true);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final sections = [
      lang.pick('Паспорт', 'Passport'),
      lang.pick('История болезней', 'Medical history'),
      lang.pick('Прививки', 'Vaccines'),
      lang.pick('Лекарства', 'Medicines'),
      lang.pick('Анализы', 'Tests'),
      lang.pick('События', 'Events'),
      lang.pick('Документы', 'Documents'),
    ];

    return PageScaffold(
      title: AppStrings.s('export', lang),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lang.pick('ЧТО ВКЛЮЧИТЬ', 'WHAT TO INCLUDE'),
              style: AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.6)),
          const SizedBox(height: 10),
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                for (var i = 0; i < sections.length; i++) ...[
                  InkWell(
                    onTap: () =>
                        setState(() => selected[i] = !selected[i]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 13),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(sections[i],
                                style: AppText.cardTitle(color: c.ink)),
                          ),
                          _Check(on: selected[i], c: c),
                        ],
                      ),
                    ),
                  ),
                  if (i != sections.length - 1)
                    Divider(height: 1, color: c.line, indent: 14, endIndent: 14),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(lang.pick('ФОРМАТ', 'FORMAT'),
              style: AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.6)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _FormatCard(
                  label: 'PDF',
                  icon: 'fileText',
                  selected: format == 0,
                  onTap: () => setState(() => format = 0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FormatCard(
                  label: lang.pick('Текстовый отчёт', 'Text report'),
                  icon: 'notes',
                  selected: format == 1,
                  onTap: () => setState(() => format = 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(
            label: AppStrings.s('generate', lang),
            icon: appIcon('download'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _Check extends StatelessWidget {
  const _Check({required this.on, required this.c});
  final bool on;
  final AppColors c;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: on ? c.peach : Colors.transparent,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: on ? c.peach : c.line, width: 1.8),
      ),
      child: on ? Icon(appIcon('check'), size: 15, color: c.onPeach) : null,
    );
  }
}

class _FormatCard extends StatelessWidget {
  const _FormatCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label, icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(AppRadius.r20),
          boxShadow: c.shadowSoft,
          border: Border.all(
              color: selected ? c.peach : c.line, width: selected ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(appIcon(icon),
                color: selected ? c.peachDeep : c.ink2, size: 26),
            const SizedBox(height: 8),
            Text(label,
                textAlign: TextAlign.center,
                style: AppText.cardTitle(color: c.ink)),
          ],
        ),
      ),
    );
  }
}
