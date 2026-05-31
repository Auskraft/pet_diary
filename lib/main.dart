import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'logic/active_pet_cubit.dart';
import 'logic/locale_cubit.dart';
import 'logic/nav_cubit.dart';
import 'logic/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(prefs)),
        BlocProvider(create: (_) => LocaleCubit(prefs)),
        BlocProvider(create: (_) => ActivePetCubit()),
        BlocProvider(create: (_) => NavCubit()),
      ],
      child: const PetDiaryApp(),
    ),
  );
}
