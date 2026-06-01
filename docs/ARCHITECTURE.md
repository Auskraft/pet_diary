# Архитектура — Дневник питомца

Техническая документация для разработчиков. Описывает слои, дизайн-токены, тему,
локализацию, управление состоянием, модель данных и конвенции.

---

## 1. Слои и зависимости

```
main.dart ─► app.dart ─► screens/** ─► widgets/** ─► core/theme, core/l10n, core/app_icons
                 │            │
                 └─ logic/** (Cubit) ◄─ data/** (models, mock_data)
```

- **`core/`** — фундамент без зависимостей от UI-экранов: тема, токены, иконки, строки.
- **`data/`** — модели предметной области и захардкоженные данные прототипа.
- **`logic/`** — Cubit'ы (flutter_bloc). Не зависят от виджетов.
- **`widgets/`** — переиспользуемые компоненты (аналог `ui.jsx` из дизайн-хэндоффа).
- **`screens/`** — экраны по фичам, собираются из виджетов и читают Cubit'ы.

Правило: экраны зависят от виджетов и логики; виджеты зависят только от `core` и `data`;
`core` ни от чего не зависит.

---

## 2. Дизайн-токены

Источник истины — hi-fi дизайн-хэндофф. Все значения вынесены в
`core/theme/app_colors.dart` как `ThemeExtension<AppColors>`.

### Цвета — светлая тема

| Токен | Hex | Назначение |
|---|---|---|
| `bg0` | `#FFFDF9` | Основной фон (тёплый off-white) |
| `bg1` | `#FAF7F2` | Фон страницы / Scaffold |
| `bg2` | `#F7F4EE` | Инсет-поля, чипы, icon-wells |
| `surface` | `#FFFFFF` | Карточки |
| `surface2` | `#FBF8F3` | Альт. поверхность |
| `ink` | `#2B2B2B` | Основной текст |
| `ink2` | `#6E675F` | Вторичный текст |
| `ink3` | `#A49C92` | Подписи / placeholder |
| `line` | `#EFE8DE` | Границы / разделители |
| `peach` / `peachDeep` / `peachSoft` | `#F4B8A8` / `#D88A73` / `#FCEDE7` | Основной акцент |
| `onPeach` | `#5A3325` | Текст на залитой персиковой кнопке (тёплый коричневый) |
| `sage` / `sageDeep` / `sageSoft` | `#B7C8B5` / `#7E9A7B` / `#EBF1EA` | Здоровье |
| `blue` / `blueDeep` / `blueSoft` | `#AFC6D9` / `#6E97B4` / `#E9F0F5` | Измерения / визиты |
| `beige` / `beigeDeep` / `beigeSoft` | `#E8D8C8` / `#B08E6E` / `#F6EFE7` | Уход / кормление |

### Цвета — тёмная тема (тёплая, не чёрная)

`bg0 #1F1F1F`, `bg1 #1A1A1A`, `bg2 #252525`, `surface #2B2B2B`, `ink #F2EDE6`,
`ink2 #B6AEA4`, `ink3 #807A71`, `line #383634`. Акцентные hue (peach/sage/blue/beige)
**одинаковы в обеих темах** — меняются только фоны, текст и soft-тинты.

### Прочие токены

- **Отступы** (`AppSpacing`): 4 / 8 / 12 / 16 / 24 / 32; паддинг экрана ≈ 20.
- **Радиусы** (`AppRadius`): 12 / 16 / 20 / 24 / 28; карточки обычно 24; pill = 999.
- **Тени**: `shadowSoft`, `shadowMedium`, `shadowUp` (в `AppColors`).
- **Анимации** (`AppMotion`): тема 450 мс; sheet 420 мс `cubic-bezier(.22,1,.36,1)`.

---

## 3. Тема

`AppColors` подключается к `ThemeData` через `extensions` в `core/theme/app_theme.dart`
(`AppTheme.light()` / `AppTheme.dark()`). Доступ из любого виджета:

```dart
final c = context.colors;            // extension в app_colors.dart
Container(color: c.bg2, ... );
Text('...', style: AppText.cardTitle(color: c.ink));
```

`AppColors` поддерживает `lerp`, поэтому `AnimatedTheme` в `app.dart` плавно
анимирует смену темы.

Тинты по строковому ключу (`'peach'|'sage'|'blue'|'beige'`):

```dart
c.tintBase('sage');   // основной
c.tintDeep('sage');   // для иконки/текста
c.tintSoft('sage');   // фон-подложка
```

### Типографика (`AppText`)

Шрифт — Nunito (`google_fonts`) как rounded-fallback к SF Pro. Методы возвращают
`TextStyle`; цвет передаётся явно из `context.colors`:

`bigTitle` · `screenTitle` · `section` · `cardTitle` · `body` / `bodyStrong` ·
`caption` · `tiny`.

---

## 4. Локализация (RU / EN)

`core/l10n/app_strings.dart`:

```dart
enum Lang { ru, en }
extension LangX on Lang { String pick(String ru, String en); }   // выбор по языку
abstract class AppStrings { static String s(String key, Lang lang); }  // таблица строк
```

Доступ из виджета (extension в `logic/locale_cubit.dart`):

```dart
final lang = context.lang;            // реактивно (watch)
context.tr('save');                   // = AppStrings.s('save', context.lang)
lang.pick('Сохранить', 'Save');       // для строк вне общей таблицы
pet.localName(lang);                  // у моделей есть localX(Lang)
```

**Добавить строку:** допиши пару в `AppStrings._t` (`'key': ['рус', 'eng']`) и используй
`context.tr('key')`. Для разовых строк прямо в экране — `lang.pick('…', '…')`.

Язык хранится в `LocaleCubit` и персистится в `shared_preferences`.

---

## 5. Управление состоянием (flutter_bloc)

Четыре Cubit'а регистрируются в `main.dart` через `MultiBlocProvider`:

| Cubit | Состояние | Назначение | Персист |
|---|---|---|---|
| `ThemeCubit` | `ThemeMode` | light / dark / system | ✅ |
| `LocaleCubit` | `Lang` | ru / en | ✅ |
| `ActivePetCubit` | `Pet` | активный питомец (драйвит pet-scoped экраны) | — |
| `NavCubit` | `int` | индекс нижней вкладки (0..4) | — |

Чтение / изменение:

```dart
final mode = context.watch<ThemeCubit>().state;       // подписка
context.read<ThemeCubit>().setMode(ThemeMode.dark);   // действие
context.read<ActivePetCubit>().select(pet);
```

> Доменные данные (питомцы, события) пока статические в `data/mock_data.dart`.
> При переходе на реальное хранилище — добавить репозитории и Cubit'ы поверх модели
> `Event`, не меняя UI-слой.

---

## 6. Модель данных

Архитектурное ядро — **«всё это Event»**. Разделы Здоровье / Уход / История — это
фильтры над общим потоком событий.

| Модель (`data/models.dart`) | Ключевые поля |
|---|---|
| `Pet` | id, name, species, breed, sex, born, age, tint, weight, sterilized, chip, allergies, traits, chronic, color (+ `*En`) |
| `PetEvent` | id, **type**, day/mon, title, sub, time, tags |
| `EventMonth` | month + `List<PetEvent>` (группировка таймлайна) |
| `EventTypeMeta` | icon, tint, label — визуальные метаданные типа |
| `Reminder` | title, sub, time, repeat, **state** (`quiet/critical/snooze/done`), done |
| `AppDocument` | name, type, kind (`pdf`/`photo`), date, size |
| `CategoryTile` | id, icon, tint, label, count (плитки Здоровье/Уход) |
| `FeedingItem`, `FilterChipData` | данные для соответствующих экранов |

У всех моделей есть методы `localX(Lang)` для RU/EN.

Маппинг типа события → иконка + тинт — единый источник `kEventTypes` в `mock_data.dart`,
обёрнут хелпером `eventMeta(type)`. Виджет `EventIconWell(type:)` рендерит событие.

Типы событий: `vaccine, medicine, visit, analysis, weight, care, grooming, walk,
feeding, note, photo`.

---

## 7. Иконки

`core/app_icons.dart` → `appIcon('name')` отдаёт `IconData` из Lucide. Часть иконок
отсутствует в пакете, подобраны близкие замены:

| Ключ | Замена | Ключ | Замена |
|---|---|---|---|
| `weight` | `scale` | `walk` | `footprints` |
| `bowl` | `utensils` | `flask` | `flaskConical` |
| `tooth` | `sparkles` | `paw` | `scissors` |
| `toilet` | `bath` | `notes` | `stickyNote` |

Неизвестный ключ → `circle` (fallback).

---

## 8. Навигация

- **Нижние вкладки**: `MainShell` (`screens/shell/`) держит `IndexedStack` из 5 корневых
  экранов; активный индекс — в `NavCubit`. `AppBottomNav` рисует таб-бар (активный таб —
  персиковая пилюля + персиковый лейбл).
- **Подэкраны**: `Navigator.push(MaterialPageRoute(...))` поверх shell. Каркас подэкрана —
  `PageScaffold` (`widgets/page_scaffold.dart`): шапка с back-стрелкой, заголовком и
  actions.
- **Bottom sheets** (добавление события / напоминания / питомца, переключение питомца):
  `showAppSheet(context, child)` + `SheetHeader` (Отмена / Заголовок / Сохранить),
  с drag-handle и затемнением.

---

## 9. UI-компоненты (`widgets/`)

`app_widgets.dart`: `AppCard`, `AppButton` (primary/secondary/dashed), `AppIconButton`,
`AppChip`, `AppSegment`, `AppTag`, `IconWell`, `EventIconWell`, `EventRow`,
`CategoryTileCard`, `ListRowTile`, `AppField`, `AppToggle`, `StatePlaceholder`,
`DashedBorder`, `PetAvatar`.

Отдельно: `bottom_nav.dart` (`AppBottomNav`), `app_sheet.dart` (`showAppSheet`,
`SheetHeader`), `page_scaffold.dart` (`PageScaffold`, `HeaderAction`),
`pet_selector_header.dart` (`PetSelectorHeader`).

---

## 10. Гайды

### Добавить новый экран
1. Создай файл в `screens/<feature>/<name>_screen.dart`.
2. Каркас — `PageScaffold(title: ..., child: ...)` (для подэкрана) или свой `Scaffold`
   с `SafeArea` (для корневой вкладки).
3. Цвета — `context.colors`, текст — `AppText.*`, строки — `context.tr` / `lang.pick`.
4. Открытие: `Navigator.push(MaterialPageRoute(builder: (_) => const NameScreen()))`.

### Добавить новый тип события
1. Добавь запись в `kEventTypes` (`mock_data.dart`): `'key': EventTypeMeta('icon','tint','Рус','Eng')`.
2. Если иконки нет в Lucide — добавь ключ и замену в `appIcon` (`core/app_icons.dart`).
3. Дублирующий маппинг в `EventIconWell` (`_eventLookup` в `app_widgets.dart`) тоже
   обнови (он повторяет иконку/тинт по типу).

### Добавить строку локализации
Допиши пару в `AppStrings._t`: `'key': ['рус', 'eng']` → используй `context.tr('key')`.

### Добавить токен цвета
Добавь поле в `AppColors` (+ в `light`, `dark`, `copyWith`, `lerp`) → доступ `context.colors.<name>`.

---

## 11. Известные ограничения / технический долг

- **Данные — мок** (`mock_data.dart`); добавление питомцев/событий не сохраняется. Нужен
  слой репозиториев + локальная БД (drift/isar).
- **Напоминания** — только UI; нет реальных локальных уведомлений.
- **Бэкап Яндекс.Диск / экспорт PDF** — экраны-заглушки без интеграции.
- **Шрифт Nunito** подтягивается `google_fonts` в рантайме (нужен интернет при первом
  запуске). Для офлайна — забандлить `.ttf` в `assets`.
- **Дублирование маппинга** типа события (в `mock_data.dart` и в `_eventLookup`
  `app_widgets.dart`) — кандидат на объединение.
- **Gradle loopback** в некоторых средах (см. README → Troubleshooting) — проблема
  окружения, не кода.
