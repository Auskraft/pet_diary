import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../pets/add_pet_sheet.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _controller = PageController();
  int page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Text(AppStrings.s('skip', lang),
                      style: AppText.bodyStrong(color: c.ink3)),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => page = i),
                children: [
                  _Page(
                    emoji: '🐾',
                    title: AppStrings.s('welcomeTitle', lang),
                    sub: AppStrings.s('slogan', lang),
                  ),
                  _Page(
                    emoji: '🐱',
                    title: AppStrings.s('addFirstPet', lang),
                    sub: lang.pick(
                        'Создайте профиль и начните историю жизни питомца',
                        'Create a profile and start your pet’s story'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 2; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == page ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == page ? c.peach : c.line,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screen),
              child: AppButton(
                label: page == 0
                    ? AppStrings.s('next', lang)
                    : AppStrings.s('addPet', lang),
                onPressed: () {
                  if (page == 0) {
                    _controller.nextPage(
                        duration: AppMotion.sheet, curve: AppMotion.sheetCurve);
                  } else {
                    Navigator.of(context).maybePop();
                    showAddPetSheet(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.emoji, required this.title, required this.sub});
  final String emoji, title, sub;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: c.peachSoft, shape: BoxShape.circle),
            child: Text(emoji, style: const TextStyle(fontSize: 76)),
          ),
          const SizedBox(height: 32),
          Text(title,
              textAlign: TextAlign.center,
              style: AppText.bigTitle(color: c.ink)),
          const SizedBox(height: 12),
          Text(sub,
              textAlign: TextAlign.center,
              style: AppText.body(color: c.ink2)),
        ],
      ),
    );
  }
}
