import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/page_scaffold.dart';

class StyleGuideScreen extends StatelessWidget {
  const StyleGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    final swatches = <(String, Color)>[
      ('bg0', c.bg0),
      ('bg2', c.bg2),
      ('peach', c.peach),
      ('peachDeep', c.peachDeep),
      ('sage', c.sage),
      ('blue', c.blue),
      ('beige', c.beige),
      ('ink', c.ink),
    ];

    return PageScaffold(
      title: lang.pick('Дизайн-система', 'Style guide'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: c.peachSoft, shape: BoxShape.circle),
                child: const Text('🐾', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.s('welcomeTitle', lang),
                        style: AppText.screenTitle(color: c.ink)),
                    Text(AppStrings.s('slogan', lang),
                        style: AppText.caption(color: c.ink3)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _Label(lang.pick('Цвета', 'Colors')),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final s in swatches)
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: s.$2,
                        borderRadius: BorderRadius.circular(AppRadius.r16),
                        border: Border.all(color: c.line),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(s.$1, style: AppText.tiny(color: c.ink3)),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 22),
          _Label(lang.pick('Типографика', 'Typography')),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang.pick('Заголовок', 'Heading'),
                    style: AppText.bigTitle(color: c.ink)),
                const SizedBox(height: 6),
                Text(lang.pick('Подзаголовок секции', 'Section title'),
                    style: AppText.section(color: c.ink)),
                const SizedBox(height: 6),
                Text(
                    lang.pick('Основной текст — спокойный и читаемый.',
                        'Body text — calm and readable.'),
                    style: AppText.body(color: c.ink2)),
                const SizedBox(height: 6),
                Text(lang.pick('Подпись / мета', 'Caption / meta'),
                    style: AppText.caption(color: c.ink3)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _Label(lang.pick('Кнопки', 'Buttons')),
          const SizedBox(height: 10),
          AppButton(label: lang.pick('Основная кнопка', 'Primary'), onPressed: () {}),
          const SizedBox(height: 10),
          AppButton(
              label: lang.pick('Второстепенная', 'Secondary'),
              variant: AppButtonVariant.secondary,
              onPressed: () {}),
          const SizedBox(height: 10),
          AppButton(
              label: lang.pick('Пунктирная', 'Dashed'),
              variant: AppButtonVariant.dashed,
              onPressed: () {}),
          const SizedBox(height: 22),
          _Label(lang.pick('Метки и чипы', 'Tags & chips')),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppTag(lang.pick('Прививка', 'Vaccine'), tint: 'sage'),
              AppTag(lang.pick('Лекарство', 'Medicine'), tint: 'peach'),
              AppTag(lang.pick('Анализ', 'Test'), tint: 'beige'),
              AppChip(label: lang.pick('Выбран', 'Selected'), selected: true, onTap: () {}),
              AppChip(label: lang.pick('Обычный', 'Default'), selected: false, onTap: () {}),
            ],
          ),
          const SizedBox(height: 22),
          _Label(lang.pick('Поле и сегмент', 'Field & segment')),
          const SizedBox(height: 10),
          AppField(label: lang.pick('Название', 'Title'), value: 'Мурка'),
          const SizedBox(height: 12),
          AppSegment(
              options: const ['♀', '♂'], index: 0, onChanged: (_) {}),
          const SizedBox(height: 22),
          _Label(lang.pick('Иконки событий', 'Event icons')),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final t in [
                'vaccine',
                'medicine',
                'visit',
                'analysis',
                'weight',
                'grooming',
                'walk',
                'feeding',
              ])
                EventIconWell(type: t, size: 44),
            ],
          ),
          const SizedBox(height: 22),
          _Label(lang.pick('Нижняя навигация', 'Bottom navigation')),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.r20),
            child: AppBottomNav(
                currentIndex: 0, lang: lang, onTap: (_) {}),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Text(text.toUpperCase(),
        style: AppText.tiny(color: c.ink3).copyWith(letterSpacing: 0.8));
  }
}
