import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../../logic/locale_cubit.dart';
import '../../logic/nav_cubit.dart';
import '../../widgets/bottom_nav.dart';
import '../care/care_screen.dart';
import '../health/health_screen.dart';
import '../overview/overview_screen.dart';
import '../pets/pets_list_screen.dart';
import '../profile/profile_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const _tabs = [
    OverviewScreen(),
    PetsListScreen(),
    HealthScreen(),
    CareScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final index = context.watch<NavCubit>().state;
    final lang = context.lang;

    return Scaffold(
      backgroundColor: c.bg1,
      body: IndexedStack(index: index, children: _tabs),
      bottomNavigationBar: AppBottomNav(
        currentIndex: index,
        lang: lang,
        onTap: (i) => context.read<NavCubit>().setTab(i),
      ),
    );
  }
}
