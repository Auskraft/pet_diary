import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/mock_data.dart';
import '../data/models.dart';

/// Tracks the currently selected pet. Drives Overview, Pet card, Health,
/// Care, History, Documents, Export — everything pet-scoped.
class ActivePetCubit extends Cubit<Pet> {
  ActivePetCubit() : super(kPets.first);

  void select(Pet pet) => emit(pet);

  void selectById(String id) =>
      emit(kPets.firstWhere((p) => p.id == id, orElse: () => state));
}
