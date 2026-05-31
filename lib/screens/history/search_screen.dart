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
import '../events/event_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PetEvent> get _all =>
      [for (final g in kTimeline) ...g.items];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    final recents = lang.isRu
        ? ['Прививка', 'Вес', 'Аллергия', 'Апрель']
        : ['Vaccine', 'Weight', 'Allergy', 'April'];

    final results = query.isEmpty
        ? <PetEvent>[]
        : _all.where((e) {
            final q = query.toLowerCase();
            return e.localTitle(lang).toLowerCase().contains(q) ||
                e.localSub(lang).toLowerCase().contains(q);
          }).toList();

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, AppSpacing.screen, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: c.bg2,
                        borderRadius: BorderRadius.circular(AppRadius.r16),
                      ),
                      child: Row(
                        children: [
                          Icon(appIcon('search'), size: 20, color: c.ink3),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              onChanged: (v) => setState(() => query = v),
                              style: AppText.bodyStrong(color: c.ink),
                              cursorColor: c.peachDeep,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: AppStrings.s('search', lang),
                                hintStyle: AppText.body(color: c.ink3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Text(AppStrings.s('cancel', lang),
                        style: AppText.bodyStrong(color: c.peachDeep)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: query.isEmpty
                  ? _Recents(recents: recents, onTap: (q) {
                      _controller.text = q;
                      setState(() => query = q);
                    })
                  : results.isEmpty
                      ? StatePlaceholder(
                          title: AppStrings.s('emptyTitle', lang),
                          subtitle: lang.pick(
                              'Ничего не найдено по запросу', 'No results found'),
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(
                              AppSpacing.screen, 8, AppSpacing.screen, 24),
                          children: [
                            for (final e in results) ...[
                              EventRow(
                                event: e,
                                lang: lang,
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            EventDetailScreen(event: e))),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Recents extends StatelessWidget {
  const _Recents({required this.recents, required this.onTap});
  final List<String> recents;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen, 8, AppSpacing.screen, 24),
      children: [
        Text(lang.pick('Недавние запросы', 'Recent searches'),
            style: AppText.caption(color: c.ink3)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final q in recents)
              AppChip(label: q, selected: false, onTap: () => onTap(q)),
          ],
        ),
      ],
    );
  }
}
