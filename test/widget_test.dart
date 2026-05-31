import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pet_diary/core/theme/app_colors.dart';
import 'package:pet_diary/core/theme/app_theme.dart';
import 'package:pet_diary/widgets/app_widgets.dart';

void main() {
  testWidgets('AppButton renders its label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: AppButton(label: 'Сохранить', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Сохранить'), findsOneWidget);
  });

  test('Design tokens expose the canonical peach accent', () {
    expect(AppColors.light.peach, const Color(0xFFF4B8A8));
    expect(AppColors.dark.bg0, const Color(0xFF1F1F1F));
  });
}
