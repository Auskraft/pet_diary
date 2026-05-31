import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_dimens.dart';
import '../core/theme/app_text.dart';

/// Shows a bottom sheet with the app's rounded, scrim & drag-handle style.
Future<T?> showAppSheet<T>(BuildContext context, Widget child) {
  final c = context.colors;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x52281C14),
    builder: (_) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.92,
        ),
        decoration: BoxDecoration(
          color: c.bg1,
          borderRadius: AppRadius.sheet,
        ),
        child: child,
      ),
    ),
  );
}

/// Header bar for a sheet: «Отмена / Title / Save».
class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    required this.title,
    required this.leadingLabel,
    required this.trailingLabel,
    this.onTrailing,
  });
  final String title;
  final String leadingLabel;
  final String trailingLabel;
  final VoidCallback? onTrailing;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: c.line,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(leadingLabel,
                    style: AppText.bodyStrong(color: c.ink2)),
              ),
              Expanded(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: AppText.screenTitle(color: c.ink)),
              ),
              GestureDetector(
                onTap: onTrailing ?? () => Navigator.of(context).pop(),
                child: Text(trailingLabel,
                    style: AppText.bodyStrong(color: c.peachDeep)),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: c.line),
      ],
    );
  }
}
