import 'package:flutter/material.dart';

import '../core/app_icons.dart';
import '../core/l10n/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_dimens.dart';
import '../core/theme/app_text.dart';
import '../data/models.dart';

// ─────────────────────────────────────────────────────────────────────────
// Pet avatar — emoji on a soft-tint circle.
// ─────────────────────────────────────────────────────────────────────────
class PetAvatar extends StatelessWidget {
  const PetAvatar({super.key, required this.pet, this.size = 44});
  final Pet pet;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.tintSoft(pet.tint),
        shape: BoxShape.circle,
        border: Border.all(color: c.line, width: 1),
      ),
      child: Text(pet.emoji, style: TextStyle(fontSize: size * 0.48)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Card surface.
// ─────────────────────────────────────────────────────────────────────────
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.x16),
    this.onTap,
    this.color,
    this.radius = AppRadius.r24,
    this.border = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? color;
  final double radius;
  final bool border;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? c.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: onTap == null && color != null ? null : c.shadowSoft,
        border: border ? Border.all(color: c.line) : null,
      ),
      child: child,
    );
    if (onTap == null) return body;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: body,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Tag pill.
// ─────────────────────────────────────────────────────────────────────────
class AppTag extends StatelessWidget {
  const AppTag(this.label, {super.key, this.tint = 'peach'});
  final String label;
  final String tint;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.tintSoft(tint),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(label, style: AppText.tiny(color: c.tintDeep(tint))),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Selectable chip (filter / type / species / repeat).
// ─────────────────────────────────────────────────────────────────────────
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
            horizontal: icon == null ? 16 : 13, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? c.peach : c.bg2,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(appIcon(icon!),
                  size: 16, color: selected ? c.onPeach : c.ink2),
              const SizedBox(width: 6),
            ],
            Text(label,
                style: AppText.caption(color: selected ? c.onPeach : c.ink2)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Connected segmented control (e.g. sex ♀/♂).
// ─────────────────────────────────────────────────────────────────────────
class AppSegment extends StatelessWidget {
  const AppSegment({
    super.key,
    required this.options,
    required this.index,
    required this.onChanged,
  });
  final List<String> options;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.bg2,
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: Row(
        children: [
          for (var i = 0; i < options.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == index ? c.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                    boxShadow: i == index ? c.shadowSoft : null,
                  ),
                  child: Text(
                    options[i],
                    style: AppText.bodyStrong(
                        color: i == index ? c.ink : c.ink2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Buttons.
// ─────────────────────────────────────────────────────────────────────────
enum AppButtonVariant { primary, secondary, dashed }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isPrimary = variant == AppButtonVariant.primary;
    final fg = isPrimary ? c.onPeach : c.ink;

    Widget content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 8),
        ],
        Text(label, style: AppText.bodyStrong(color: fg)),
      ],
    );

    final radius = BorderRadius.circular(AppRadius.r16);
    final child = Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPrimary ? c.peach : c.surface,
        borderRadius: radius,
        boxShadow: isPrimary ? c.shadowSoft : null,
        border: variant == AppButtonVariant.secondary
            ? Border.all(color: c.line, width: 1.4)
            : null,
      ),
      child: content,
    );

    final tappable = Material(
      color: Colors.transparent,
      child: InkWell(borderRadius: radius, onTap: onPressed, child: child),
    );

    if (variant == AppButtonVariant.dashed) {
      return SizedBox(
        width: expand ? double.infinity : null,
        child: DashedBorder(
          color: c.line,
          radius: AppRadius.r16,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: radius,
              onTap: onPressed,
              child: Container(
                height: 52,
                alignment: Alignment.center,
                child: content,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(width: expand ? double.infinity : null, child: tappable);
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
    this.tint,
    this.badge = false,
  });
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final String? tint;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint == null ? c.bg2 : c.tintSoft(tint!),
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: Icon(icon,
                size: size * 0.45,
                color: tint == null ? c.ink2 : c.tintDeep(tint!)),
          ),
          if (badge)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: c.peach, shape: BoxShape.circle),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Event icon well (soft tint + deep icon), keyed by event type.
// ─────────────────────────────────────────────────────────────────────────
class EventIconWell extends StatelessWidget {
  const EventIconWell({super.key, required this.type, this.size = 44});
  final String type;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final meta = _metaFor(type);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.tintSoft(meta.tint),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Icon(appIcon(meta.icon),
          size: size * 0.45, color: c.tintDeep(meta.tint)),
    );
  }

  static _IconTint _metaFor(String type) {
    // Light wrapper so EventIconWell can be used with arbitrary type keys.
    return _eventLookup[type] ?? const _IconTint('notes', 'beige');
  }
}

class _IconTint {
  final String icon;
  final String tint;
  const _IconTint(this.icon, this.tint);
}

const Map<String, _IconTint> _eventLookup = {
  'vaccine': _IconTint('syringe', 'sage'),
  'medicine': _IconTint('pill', 'peach'),
  'visit': _IconTint('stethoscope', 'blue'),
  'analysis': _IconTint('flask', 'beige'),
  'weight': _IconTint('weight', 'blue'),
  'care': _IconTint('bug', 'sage'),
  'grooming': _IconTint('scissors', 'peach'),
  'walk': _IconTint('walk', 'sage'),
  'feeding': _IconTint('bowl', 'beige'),
  'note': _IconTint('notes', 'beige'),
  'photo': _IconTint('image', 'blue'),
};

/// A generic icon well by explicit icon name + tint (Health/Care tiles).
class IconWell extends StatelessWidget {
  const IconWell(
      {super.key, required this.icon, required this.tint, this.size = 44});
  final String icon;
  final String tint;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.tintSoft(tint),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child:
          Icon(appIcon(icon), size: size * 0.45, color: c.tintDeep(tint)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Section title row.
// ─────────────────────────────────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.action, this.onAction});
  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppText.section(color: c.ink)),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(action!, style: AppText.caption(color: c.peachDeep)),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Settings / list row.
// ─────────────────────────────────────────────────────────────────────────
class ListRowTile extends StatelessWidget {
  const ListRowTile({
    super.key,
    this.icon,
    this.iconTint,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showChevron = true,
  });
  final String? icon;
  final String? iconTint;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.r16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              IconWell(icon: icon!, tint: iconTint ?? 'peach', size: 38),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.cardTitle(color: c.ink)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: AppText.caption(color: c.ink3)),
                  ],
                ],
              ),
            ),
            ?trailing,
            if (trailing == null && showChevron)
              Icon(appIcon('chevronRight'), size: 18, color: c.ink3),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Labeled field (read-only value, prototype style).
// ─────────────────────────────────────────────────────────────────────────
class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.label,
    this.value,
    this.child,
    this.onTap,
    this.trailingIcon = 'chevronRight',
  });
  final String label;
  final String? value;
  final Widget? child;
  final VoidCallback? onTap;
  final String? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
            style: AppText.tiny(color: c.ink3)
                .copyWith(letterSpacing: 0.6)),
        const SizedBox(height: 6),
        InkWell(
          borderRadius: BorderRadius.circular(AppRadius.r16),
          onTap: onTap,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: c.bg2,
              borderRadius: BorderRadius.circular(AppRadius.r16),
            ),
            child: child ??
                Row(
                  children: [
                    Expanded(
                      child: Text(value ?? '',
                          style: AppText.bodyStrong(color: c.ink)),
                    ),
                    if (onTap != null && trailingIcon != null)
                      Icon(appIcon(trailingIcon!), size: 18, color: c.ink3),
                  ],
                ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Toggle.
// ─────────────────────────────────────────────────────────────────────────
class AppToggle extends StatelessWidget {
  const AppToggle({super.key, required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(3),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          color: value ? c.peach : c.line,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: c.surface,
            shape: BoxShape.circle,
            boxShadow: c.shadowSoft,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Empty / status state.
// ─────────────────────────────────────────────────────────────────────────
class StatePlaceholder extends StatelessWidget {
  const StatePlaceholder({
    super.key,
    required this.title,
    required this.subtitle,
    this.emoji,
    this.iconWidget,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });
  final String title;
  final String subtitle;
  final String? emoji;
  final Widget? iconWidget;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.peachSoft,
                shape: BoxShape.circle,
              ),
              child: iconWidget ??
                  Text(emoji ?? '🐾',
                      style: const TextStyle(fontSize: 44)),
            ),
            const SizedBox(height: 20),
            Text(title,
                textAlign: TextAlign.center,
                style: AppText.screenTitle(color: c.ink)),
            const SizedBox(height: 8),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: AppText.body(color: c.ink2)),
            if (primaryLabel != null) ...[
              const SizedBox(height: 24),
              AppButton(
                  label: primaryLabel!,
                  onPressed: onPrimary,
                  expand: false),
            ],
            if (secondaryLabel != null) ...[
              const SizedBox(height: 10),
              AppButton(
                label: secondaryLabel!,
                onPressed: onSecondary,
                variant: AppButtonVariant.secondary,
                expand: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Timeline / list event row.
// ─────────────────────────────────────────────────────────────────────────
class EventRow extends StatelessWidget {
  const EventRow({
    super.key,
    required this.event,
    required this.lang,
    this.onTap,
    this.showDate = true,
  });
  final PetEvent event;
  final Lang lang;
  final VoidCallback? onTap;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          if (showDate) ...[
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  Text(event.day,
                      style: AppText.cardTitle(color: c.ink)),
                  Text(event.localMon(lang),
                      style: AppText.tiny(color: c.ink3)),
                ],
              ),
            ),
            const SizedBox(width: 4),
          ],
          EventIconWell(type: event.type, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.localTitle(lang),
                    style: AppText.cardTitle(color: c.ink)),
                const SizedBox(height: 2),
                Text(event.localSub(lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.caption(color: c.ink3)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(event.time, style: AppText.caption(color: c.ink3)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Health / Care subcategory tile.
// ─────────────────────────────────────────────────────────────────────────
class CategoryTileCard extends StatelessWidget {
  const CategoryTileCard({
    super.key,
    required this.tile,
    required this.lang,
    this.onTap,
  });
  final CategoryTile tile;
  final Lang lang;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWell(icon: tile.icon, tint: tile.tint, size: 40),
              Text('${tile.count}',
                  style: AppText.caption(color: c.ink3)),
            ],
          ),
          const SizedBox(height: 12),
          Text(tile.localLabel(lang),
              style: AppText.cardTitle(color: c.ink)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Dashed border helper.
// ─────────────────────────────────────────────────────────────────────────
class DashedBorder extends StatelessWidget {
  const DashedBorder({
    super.key,
    required this.child,
    required this.color,
    this.radius = AppRadius.r16,
    this.strokeWidth = 1.4,
  });
  final Widget child;
  final Color color;
  final double radius;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedPainter(color, radius, strokeWidth),
      child: child,
    );
  }
}

class _DashedPainter extends CustomPainter {
  _DashedPainter(this.color, this.radius, this.strokeWidth);
  final Color color;
  final double radius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    const dash = 6.0, gap = 5.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dash),
          paint,
        );
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) =>
      old.color != color || old.radius != radius;
}
