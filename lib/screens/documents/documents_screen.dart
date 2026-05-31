import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';
import 'doc_view_screen.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return PageScaffold(
      title: AppStrings.s('documents', lang),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashedBorder(
            color: c.line,
            radius: AppRadius.r20,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Column(
                children: [
                  Icon(appIcon('uploadCloud'), color: c.peachDeep, size: 28),
                  const SizedBox(height: 8),
                  Text(lang.pick('Загрузить документ', 'Upload document'),
                      style: AppText.cardTitle(color: c.ink)),
                  const SizedBox(height: 2),
                  Text(lang.pick('PDF или фото · до 25 МБ',
                      'PDF or photo · up to 25 MB'),
                      style: AppText.caption(color: c.ink3)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          for (final doc in kDocuments) ...[
            _DocCard(doc: doc, lang: lang),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _DocCard extends StatelessWidget {
  const _DocCard({required this.doc, required this.lang});
  final AppDocument doc;
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isPdf = doc.kind == 'pdf';
    return AppCard(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DocViewScreen(doc: doc))),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isPdf ? c.peachSoft : c.blueSoft,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: Icon(appIcon(isPdf ? 'fileText' : 'image'),
                color: isPdf ? c.peachDeep : c.blueDeep, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc.localName(lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.cardTitle(color: c.ink)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    AppTag(doc.localType(lang),
                        tint: isPdf ? 'peach' : 'blue'),
                    const SizedBox(width: 8),
                    Text('${doc.localDate(lang)} · ${doc.size}',
                        style: AppText.caption(color: c.ink3)),
                  ],
                ),
              ],
            ),
          ),
          Icon(appIcon('chevronRight'), color: c.ink3, size: 18),
        ],
      ),
    );
  }
}
