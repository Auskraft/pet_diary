import 'package:flutter_bloc/flutter_bloc.dart';

/// Bottom-navigation tab index (0..4): Обзор · Питомцы · Здоровье · Уход · Профиль.
class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  void setTab(int index) => emit(index);
}
