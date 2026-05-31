import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../core/l10n/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_dimens.dart';
import '../core/theme/app_text.dart';

class _NavItem {
  final IconData icon;
  final String key;
  const _NavItem(this.icon, this.key);
}

const _items = <_NavItem>[
  _NavItem(LucideIcons.home, 'tabOverview'),
  _NavItem(LucideIcons.footprints, 'tabPets'),
  _NavItem(LucideIcons.heart, 'tabHealth'),
  _NavItem(LucideIcons.sparkles, 'tabCare'),
  _NavItem(LucideIcons.user, 'tabProfile'),
];

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.lang,
  });
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: c.bg0,
        boxShadow: c.shadowUp,
        border: Border(top: BorderSide(color: c.line, width: 0.6)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < _items.length; i++)
                _NavButton(
                  item: _items[i],
                  active: i == currentIndex,
                  label: AppStrings.s(_items[i].key, lang),
                  onTap: () => onTap(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.active,
    required this.label,
    required this.onTap,
  });
  final _NavItem item;
  final bool active;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            decoration: BoxDecoration(
              color: active ? c.peachSoft : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Icon(item.icon,
                size: 22, color: active ? c.peachDeep : c.ink3),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: AppText.tiny(color: active ? c.peachDeep : c.ink3)),
        ],
      ),
    );
  }
}
