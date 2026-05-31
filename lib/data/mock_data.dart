import 'models.dart';

/// Hardcoded prototype data — mirrors `data.jsx` from the design handoff.
/// In production this is replaced by the Event model + per-pet repositories.

const List<Pet> kPets = [
  Pet(
    id: 'murka', name: 'Мурка', nameEn: 'Murka', emoji: '🐱',
    species: 'Кошка', speciesEn: 'Cat',
    breed: 'Британская короткошёрстная', breedEn: 'British Shorthair',
    sex: 'Самка', sexGlyph: '♀',
    born: '21 марта 2021', bornEn: 'March 21, 2021',
    age: '3 года 2 месяца', ageEn: '3 yr 2 mo',
    tint: 'peach',
    weight: '4,2 кг', weightEn: '4.2 kg',
    sterilized: 'Да', sterilizedEn: 'Yes',
    chip: '643 098 100 742 357',
    allergies: 'Курица, пыльца', allergiesEn: 'Chicken, pollen',
    traits: 'Боится громких звуков', traitsEn: 'Afraid of loud noises',
    chronic: 'Нет', chronicEn: 'None',
    color: 'Голубой', colorEn: 'Blue',
  ),
  Pet(
    id: 'barney', name: 'Барни', nameEn: 'Barney', emoji: '🐶',
    species: 'Собака', speciesEn: 'Dog',
    breed: 'Корги', breedEn: 'Corgi',
    sex: 'Самец', sexGlyph: '♂',
    born: '14 октября 2021', bornEn: 'October 14, 2021',
    age: '2 года 7 месяцев', ageEn: '2 yr 7 mo',
    tint: 'sage',
    weight: '11,4 кг', weightEn: '11.4 kg',
    sterilized: 'Нет', sterilizedEn: 'No',
    chip: '643 098 100 558 021',
    allergies: 'Нет', allergiesEn: 'None',
    traits: 'Очень общительный', traitsEn: 'Very sociable',
    chronic: 'Нет', chronicEn: 'None',
    color: 'Рыжий с белым', colorEn: 'Red & white',
  ),
  Pet(
    id: 'kesha', name: 'Кеша', nameEn: 'Kesha', emoji: '🦜',
    species: 'Попугай', speciesEn: 'Parrot',
    breed: 'Корелла', breedEn: 'Cockatiel',
    sex: 'Самец', sexGlyph: '♂',
    born: '2 февраля 2023', bornEn: 'February 2, 2023',
    age: '1 год 3 месяца', ageEn: '1 yr 3 mo',
    tint: 'blue',
    weight: '92 г', weightEn: '92 g',
    sterilized: '—', sterilizedEn: '—',
    chip: '—',
    allergies: 'Нет', allergiesEn: 'None',
    traits: 'Любит петь по утрам', traitsEn: 'Loves to sing in the morning',
    chronic: 'Нет', chronicEn: 'None',
    color: 'Серый', colorEn: 'Grey',
  ),
];

const Map<String, EventTypeMeta> kEventTypes = {
  'vaccine': EventTypeMeta('syringe', 'sage', 'Прививка', 'Vaccine'),
  'medicine': EventTypeMeta('pill', 'peach', 'Лекарство', 'Medicine'),
  'visit': EventTypeMeta('stethoscope', 'blue', 'Визит', 'Visit'),
  'analysis': EventTypeMeta('flask', 'beige', 'Анализ', 'Test'),
  'weight': EventTypeMeta('weight', 'blue', 'Вес', 'Weight'),
  'care': EventTypeMeta('bug', 'sage', 'Обработка', 'Treatment'),
  'grooming': EventTypeMeta('scissors', 'peach', 'Груминг', 'Grooming'),
  'walk': EventTypeMeta('walk', 'sage', 'Прогулка', 'Walk'),
  'feeding': EventTypeMeta('bowl', 'beige', 'Кормление', 'Feeding'),
  'note': EventTypeMeta('notes', 'beige', 'Заметка', 'Note'),
  'photo': EventTypeMeta('image', 'blue', 'Фото', 'Photo'),
};

EventTypeMeta eventMeta(String type) =>
    kEventTypes[type] ?? kEventTypes['note']!;

const List<EventMonth> kTimeline = [
  EventMonth(month: 'Май 2024', monthEn: 'May 2024', items: [
    PetEvent(id: 'e1', type: 'medicine', day: '12', mon: 'мая', monEn: 'May', title: 'Дать лекарство', titleEn: 'Give medicine', sub: 'Гептрал · 1/2 таб', subEn: 'Heptral · ½ tab', time: '20:00', tags: ['Лечение']),
    PetEvent(id: 'e2', type: 'visit', day: '7', mon: 'мая', monEn: 'May', title: 'Плановый осмотр', titleEn: 'Routine check-up', sub: 'Ветклиника «Лапки»', subEn: '«Lapki» Vet Clinic', time: '11:30', tags: ['Визит', 'Осмотр']),
    PetEvent(id: 'e3', type: 'care', day: '5', mon: 'мая', monEn: 'May', title: 'Обработка от блох', titleEn: 'Flea treatment', sub: 'Бравекто', subEn: 'Bravecto', time: '09:00', tags: ['Профилактика']),
  ]),
  EventMonth(month: 'Апрель 2024', monthEn: 'April 2024', items: [
    PetEvent(id: 'e4', type: 'vaccine', day: '20', mon: 'апр', monEn: 'Apr', title: 'Прививка', titleEn: 'Vaccination', sub: 'Мультифел-4', subEn: 'Multifel-4', time: '12:00', tags: ['Прививка']),
    PetEvent(id: 'e5', type: 'analysis', day: '15', mon: 'апр', monEn: 'Apr', title: 'Анализ крови', titleEn: 'Blood test', sub: 'Биохимия, ОАК', subEn: 'Biochemistry, CBC', time: '10:15', tags: ['Анализ']),
  ]),
  EventMonth(month: 'Март 2024', monthEn: 'March 2024', items: [
    PetEvent(id: 'e6', type: 'weight', day: '21', mon: 'мар', monEn: 'Mar', title: 'Вес', titleEn: 'Weight', sub: '4,1 кг', subEn: '4.1 kg', time: '08:30', tags: ['Измерение']),
  ]),
];

const List<Reminder> kReminders = [
  Reminder(id: 'r1', title: 'Дать лекарство', titleEn: 'Give medicine', sub: 'Гептрал 1/2 таб', subEn: 'Heptral ½ tab', time: 'Сегодня в 20:00', timeEn: 'Today at 8:00 PM', repeat: 'Каждый день', repeatEn: 'Every day', state: ReminderState.critical, done: false),
  Reminder(id: 'r2', title: 'Прививка Мультифел-4', titleEn: 'Multifel-4 vaccine', sub: 'Ежегодная ревакцинация', subEn: 'Annual booster', time: '30 мая в 12:00', timeEn: 'May 30 at 12:00 PM', repeat: 'Каждый год', repeatEn: 'Every year', state: ReminderState.quiet, done: false),
  Reminder(id: 'r3', title: 'Обработка от клещей', titleEn: 'Tick treatment', sub: 'Бравекто', subEn: 'Bravecto', time: 'Завтра в 09:00', timeEn: 'Tomorrow at 9:00 AM', repeat: 'Каждый месяц', repeatEn: 'Monthly', state: ReminderState.snooze, done: false),
  Reminder(id: 'r4', title: 'Взвесить Мурку', titleEn: 'Weigh Murka', sub: 'Контроль веса', subEn: 'Weight check', time: '11 мая', timeEn: 'May 11', repeat: 'Каждую неделю', repeatEn: 'Weekly', state: ReminderState.done, done: true),
];

const List<AppDocument> kDocuments = [
  AppDocument(id: 'd1', name: 'Ветеринарный паспорт', nameEn: 'Veterinary passport', type: 'Паспорт', typeEn: 'Passport', kind: 'pdf', date: '21 мар 2021', dateEn: 'Mar 21, 2021', size: '2,4 МБ'),
  AppDocument(id: 'd2', name: 'Биохимия крови', nameEn: 'Blood biochemistry', type: 'Анализ', typeEn: 'Test', kind: 'pdf', date: '15 апр 2024', dateEn: 'Apr 15, 2024', size: '860 КБ'),
  AppDocument(id: 'd3', name: 'Рецепт — Гептрал', nameEn: 'Prescription — Heptral', type: 'Рецепт', typeEn: 'Prescription', kind: 'photo', date: '7 мая 2024', dateEn: 'May 7, 2024', size: '1,1 МБ'),
  AppDocument(id: 'd4', name: 'Выписка из клиники', nameEn: 'Clinic discharge', type: 'Выписка', typeEn: 'Discharge', kind: 'pdf', date: '7 мая 2024', dateEn: 'May 7, 2024', size: '540 КБ'),
];

const List<CategoryTile> kHealthCats = [
  CategoryTile(id: 'vaccines', icon: 'syringe', tint: 'sage', label: 'Прививки', labelEn: 'Vaccines', count: 6),
  CategoryTile(id: 'meds', icon: 'pill', tint: 'peach', label: 'Лекарства', labelEn: 'Medicines', count: 3),
  CategoryTile(id: 'visits', icon: 'stethoscope', tint: 'blue', label: 'Визиты', labelEn: 'Visits', count: 9),
  CategoryTile(id: 'illness', icon: 'thermometer', tint: 'peach', label: 'Болезни', labelEn: 'Illnesses', count: 2),
  CategoryTile(id: 'allergy', icon: 'flame', tint: 'peach', label: 'Аллергии', labelEn: 'Allergies', count: 2),
  CategoryTile(id: 'surgery', icon: 'heart', tint: 'blue', label: 'Операции', labelEn: 'Surgeries', count: 1),
  CategoryTile(id: 'tests', icon: 'flask', tint: 'beige', label: 'Анализы', labelEn: 'Tests', count: 5),
  CategoryTile(id: 'parasite', icon: 'bug', tint: 'sage', label: 'Паразиты', labelEn: 'Parasites', count: 4),
  CategoryTile(id: 'symptoms', icon: 'activity', tint: 'peach', label: 'Симптомы', labelEn: 'Symptoms', count: 3),
  CategoryTile(id: 'measure', icon: 'scale', tint: 'blue', label: 'Измерения', labelEn: 'Measurements', count: 8),
];

const List<CategoryTile> kCareCats = [
  CategoryTile(id: 'feeding', icon: 'bowl', tint: 'beige', label: 'Кормление', labelEn: 'Feeding', count: 24),
  CategoryTile(id: 'diet', icon: 'heart', tint: 'peach', label: 'Рацион', labelEn: 'Diet', count: 3),
  CategoryTile(id: 'water', icon: 'droplet', tint: 'blue', label: 'Вода', labelEn: 'Water', count: 12),
  CategoryTile(id: 'walks', icon: 'walk', tint: 'sage', label: 'Прогулки', labelEn: 'Walks', count: 18),
  CategoryTile(id: 'grooming', icon: 'scissors', tint: 'peach', label: 'Груминг', labelEn: 'Grooming', count: 4),
  CategoryTile(id: 'teeth', icon: 'tooth', tint: 'blue', label: 'Зубы', labelEn: 'Teeth', count: 2),
  CategoryTile(id: 'claws', icon: 'paw', tint: 'sage', label: 'Когти', labelEn: 'Claws', count: 3),
  CategoryTile(id: 'ears', icon: 'ear', tint: 'beige', label: 'Уши', labelEn: 'Ears', count: 2),
  CategoryTile(id: 'litter', icon: 'toilet', tint: 'blue', label: 'Туалет', labelEn: 'Litter', count: 30),
  CategoryTile(id: 'activity', icon: 'activity', tint: 'sage', label: 'Активность', labelEn: 'Activity', count: 9),
  CategoryTile(id: 'sleep', icon: 'bed', tint: 'beige', label: 'Сон', labelEn: 'Sleep', count: 7),
  CategoryTile(id: 'behavior', icon: 'smile', tint: 'peach', label: 'Поведение', labelEn: 'Behavior', count: 5),
];

const List<FeedingItem> kFeeding = [
  FeedingItem(time: '08:00', title: 'Сухой корм', titleEn: 'Dry food', sub: 'Royal Canin British · 40 г', subEn: 'Royal Canin British · 40 g', emoji: '🥣'),
  FeedingItem(time: '13:30', title: 'Влажный корм', titleEn: 'Wet food', sub: 'Паучи с индейкой · 1 шт', subEn: 'Turkey pouch · 1 pc', emoji: '🍗'),
  FeedingItem(time: '16:00', title: 'Лакомство', titleEn: 'Treat', sub: 'Палочки Little One · 2 шт', subEn: 'Treat sticks · 2 pcs', emoji: '🦴'),
  FeedingItem(time: '20:00', title: 'Сухой корм', titleEn: 'Dry food', sub: 'Royal Canin British · 40 г', subEn: 'Royal Canin British · 40 g', emoji: '🥣'),
];

const List<FilterChipData> kFilterChips = [
  FilterChipData(id: 'all', label: 'Все', labelEn: 'All'),
  FilterChipData(id: 'health', label: 'Здоровье', labelEn: 'Health'),
  FilterChipData(id: 'care', label: 'Уход', labelEn: 'Care'),
  FilterChipData(id: 'meds', label: 'Лекарства', labelEn: 'Medicine'),
  FilterChipData(id: 'photo', label: 'Фото', labelEn: 'Photos'),
  FilterChipData(id: 'note', label: 'Заметки', labelEn: 'Notes'),
];

/// Pet species options for the Add-pet form.
const List<List<String>> kSpeciesOptions = [
  ['Кошка', 'Cat'],
  ['Собака', 'Dog'],
  ['Птица', 'Bird'],
  ['Кролик', 'Rabbit'],
  ['Рептилия', 'Reptile'],
  ['Грызун', 'Rodent'],
  ['Другое', 'Other'],
];

/// Repeat options for reminders.
const List<List<String>> kRepeatOptions = [
  ['Нет', 'None'],
  ['Каждый день', 'Daily'],
  ['Неделя', 'Weekly'],
  ['Месяц', 'Monthly'],
  ['Год', 'Yearly'],
];

/// Event type keys used by the Add-event type selector.
const List<String> kQuickEventTypes = ['vaccine', 'medicine', 'visit', 'analysis', 'note'];
