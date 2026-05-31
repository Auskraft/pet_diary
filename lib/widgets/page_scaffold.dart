import 'package:flutter/material.dart';

import '../core/app_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_dimens.dart';
import '../core/theme/app_text.dart';

/// A simple sub-page scaffold with a back header (chevron + title + actions).
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
    this.scroll = true,
    this.padded = true,
    this.titleWidget,
  });

  final String title;
  final Widget child;
  final List<Widget> actions;
  final bool scroll;
  final bool padded;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget content = child;
    if (padded) {
      content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screen),
        child: content,
      );
    }
    if (scroll) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 32),
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: c.bg1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, AppSpacing.screen, 8),
              child: Row(
                children: [
                  _CircleIcon(
                    icon: appIcon('chevronLeft'),
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: titleWidget ??
                        Text(title, style: AppText.screenTitle(color: c.ink)),
                  ),
                  ...actions,
                ],
              ),
            ),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(icon, size: 24, color: c.ink),
      ),
    );
  }
}

/// A pill action button used in page headers (e.g. filter / edit / search).
class HeaderAction extends StatelessWidget {
  const HeaderAction({super.key, required this.icon, required this.onTap});
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: c.bg2, shape: BoxShape.circle),
        child: Icon(appIcon(icon), size: 20, color: c.ink2),
      ),
    );
  }
}
