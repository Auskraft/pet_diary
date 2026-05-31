import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/models.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

class DocViewScreen extends StatelessWidget {
  const DocViewScreen({super.key, required this.doc});
  final AppDocument doc;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final isPdf = doc.kind == 'pdf';

    return PageScaffold(
      title: doc.localName(lang),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: Container(
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(AppRadius.r24),
                boxShadow: c.shadowSoft,
                border: Border.all(color: c.line),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(appIcon(isPdf ? 'fileText' : 'image'),
                      size: 56, color: isPdf ? c.peachDeep : c.blueDeep),
                  const SizedBox(height: 12),
                  Text(doc.localType(lang),
                      style: AppText.cardTitle(color: c.ink2)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doc.localName(lang),
                          style: AppText.cardTitle(color: c.ink)),
                      const SizedBox(height: 4),
                      Text('${doc.localDate(lang)} · ${doc.size}',
                          style: AppText.caption(color: c.ink3)),
                    ],
                  ),
                ),
                AppTag(doc.localType(lang),
                    tint: isPdf ? 'peach' : 'blue'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: lang.pick('Скачать', 'Download'),
                  icon: appIcon('download'),
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
