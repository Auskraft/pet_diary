import '../core/l10n/app_strings.dart';

/// A pet profile (passport + extended fields). Mirrors `PETS` in the handoff.
class Pet {
  final String id;
  final String name, nameEn;
  final String emoji;
  final String species, speciesEn;
  final String breed, breedEn;
  final String sex, sexGlyph;
  final String born, bornEn;
  final String age, ageEn;
  final String tint; // 'peach' | 'sage' | 'blue' | 'beige'
  final String weight, weightEn;
  final String sterilized, sterilizedEn;
  final String chip;
  final String allergies, allergiesEn;
  final String traits, traitsEn;
  final String chronic, chronicEn;
  final String color, colorEn;

  const Pet({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.emoji,
    required this.species,
    required this.speciesEn,
    required this.breed,
    required this.breedEn,
    required this.sex,
    required this.sexGlyph,
    required this.born,
    required this.bornEn,
    required this.age,
    required this.ageEn,
    required this.tint,
    required this.weight,
    required this.weightEn,
    required this.sterilized,
    required this.sterilizedEn,
    required this.chip,
    required this.allergies,
    required this.allergiesEn,
    required this.traits,
    required this.traitsEn,
    required this.chronic,
    required this.chronicEn,
    required this.color,
    required this.colorEn,
  });

  String localName(Lang l) => l.pick(name, nameEn);
  String localSpecies(Lang l) => l.pick(species, speciesEn);
  String localBreed(Lang l) => l.pick(breed, breedEn);
  String localAge(Lang l) => l.pick(age, ageEn);
  String localBorn(Lang l) => l.pick(born, bornEn);
  String localWeight(Lang l) => l.pick(weight, weightEn);
  String localSterilized(Lang l) => l.pick(sterilized, sterilizedEn);
  String localAllergies(Lang l) => l.pick(allergies, allergiesEn);
  String localTraits(Lang l) => l.pick(traits, traitsEn);
  String localChronic(Lang l) => l.pick(chronic, chronicEn);
  String localColor(Lang l) => l.pick(color, colorEn);
}

/// Visual metadata for an event type (icon + accent tint + label).
class EventTypeMeta {
  final String icon;
  final String tint;
  final String label, labelEn;
  const EventTypeMeta(this.icon, this.tint, this.label, this.labelEn);

  String localLabel(Lang l) => l.pick(label, labelEn);
}

/// A single timeline event. Mirrors `TIMELINE[].items[]`.
class PetEvent {
  final String id;
  final String type; // key into eventTypes
  final String day, mon, monEn;
  final String title, titleEn;
  final String sub, subEn;
  final String time;
  final List<String> tags;

  const PetEvent({
    required this.id,
    required this.type,
    required this.day,
    required this.mon,
    required this.monEn,
    required this.title,
    required this.titleEn,
    required this.sub,
    required this.subEn,
    required this.time,
    required this.tags,
  });

  String localTitle(Lang l) => l.pick(title, titleEn);
  String localSub(Lang l) => l.pick(sub, subEn);
  String localMon(Lang l) => l.pick(mon, monEn);
}

/// Group of events for one month.
class EventMonth {
  final String month, monthEn;
  final List<PetEvent> items;
  const EventMonth({
    required this.month,
    required this.monthEn,
    required this.items,
  });

  String localMonth(Lang l) => l.pick(month, monthEn);
}

enum ReminderState { quiet, critical, snooze, done }

class Reminder {
  final String id;
  final String title, titleEn;
  final String sub, subEn;
  final String time, timeEn;
  final String repeat, repeatEn;
  final ReminderState state;
  final bool done;

  const Reminder({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.sub,
    required this.subEn,
    required this.time,
    required this.timeEn,
    required this.repeat,
    required this.repeatEn,
    required this.state,
    required this.done,
  });

  String localTitle(Lang l) => l.pick(title, titleEn);
  String localSub(Lang l) => l.pick(sub, subEn);
  String localTime(Lang l) => l.pick(time, timeEn);
  String localRepeat(Lang l) => l.pick(repeat, repeatEn);
}

class AppDocument {
  final String id;
  final String name, nameEn;
  final String type, typeEn;
  final String kind; // 'pdf' | 'photo'
  final String date, dateEn;
  final String size;

  const AppDocument({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.type,
    required this.typeEn,
    required this.kind,
    required this.date,
    required this.dateEn,
    required this.size,
  });

  String localName(Lang l) => l.pick(name, nameEn);
  String localType(Lang l) => l.pick(type, typeEn);
  String localDate(Lang l) => l.pick(date, dateEn);
}

/// A subcategory tile in Health / Care.
class CategoryTile {
  final String id;
  final String icon;
  final String tint;
  final String label, labelEn;
  final int count;

  const CategoryTile({
    required this.id,
    required this.icon,
    required this.tint,
    required this.label,
    required this.labelEn,
    required this.count,
  });

  String localLabel(Lang l) => l.pick(label, labelEn);
}

class FeedingItem {
  final String time;
  final String title, titleEn;
  final String sub, subEn;
  final String emoji;

  const FeedingItem({
    required this.time,
    required this.title,
    required this.titleEn,
    required this.sub,
    required this.subEn,
    required this.emoji,
  });

  String localTitle(Lang l) => l.pick(title, titleEn);
  String localSub(Lang l) => l.pick(sub, subEn);
}

class FilterChipData {
  final String id;
  final String label, labelEn;
  const FilterChipData({
    required this.id,
    required this.label,
    required this.labelEn,
  });

  String localLabel(Lang l) => l.pick(label, labelEn);
}
