/// Supported UI languages.
enum Lang { ru, en }

extension LangX on Lang {
  bool get isRu => this == Lang.ru;
  String get code => this == Lang.ru ? 'ru' : 'en';
  String get title => this == Lang.ru ? 'Русский' : 'English';

  /// Picks one of two localized strings.
  String pick(String ru, String en) => this == Lang.ru ? ru : en;
}

/// UI chrome strings (mirrors `STR`/`tt` from the design handoff `data.jsx`).
abstract class AppStrings {
  static const Map<String, List<String>> _t = {
    // key: [ru, en]
    'today': ['Сегодня', 'Today'],
    'todayDate': ['Сегодня · 12 мая', 'Today · May 12'],
    'nextVaccine': ['Ближайшая прививка', 'Next vaccine'],
    'inDays': ['Через 18 дней · 30 мая', 'In 18 days · May 30'],
    'giveMed': ['Дать лекарство', 'Give medicine'],
    'todayAt': ['Сегодня в 20:00', 'Today at 8:00 PM'],
    'heptral': ['Гептрал 1/2 таб', 'Heptral ½ tab'],
    'weight': ['Вес', 'Weight'],
    'lastVisit': ['Последний визит', 'Last visit'],
    'routine': ['Плановый осмотр', 'Routine check-up'],
    'activity': ['Активность', 'Activity'],
    'recent': ['Последние события', 'Recent events'],
    'seeAll': ['Смотреть все', 'See all'],
    'todayTasks': ['Задачи на сегодня', 'Today’s tasks'],
    'tabOverview': ['Обзор', 'Overview'],
    'tabPets': ['Питомцы', 'Pets'],
    'tabHealth': ['Здоровье', 'Health'],
    'tabCare': ['Уход', 'Care'],
    'tabProfile': ['Профиль', 'Profile'],
    'pets': ['Питомцы', 'Pets'],
    'addPet': ['Добавить питомца', 'Add pet'],
    'newPet': ['Новый питомец', 'New pet'],
    'cancel': ['Отмена', 'Cancel'],
    'save': ['Сохранить', 'Save'],
    'done': ['Готово', 'Done'],
    'passport': ['Паспорт', 'Passport'],
    'documents': ['Документы', 'Documents'],
    'history': ['История', 'History'],
    'notes': ['Заметки', 'Notes'],
    'health': ['Здоровье', 'Health'],
    'care': ['Уход', 'Care'],
    'reminders': ['Напоминания', 'Reminders'],
    'newEvent': ['Новое событие', 'New event'],
    'title': ['Название', 'Title'],
    'date': ['Дата', 'Date'],
    'time': ['Время', 'Time'],
    'description': ['Описание', 'Description'],
    'reminder': ['Напоминание', 'Reminder'],
    'notSet': ['Не установлено', 'Not set'],
    'tags': ['Теги', 'Tags'],
    'files': ['Файлы', 'Files'],
    'edit': ['Редактировать', 'Edit'],
    'delete': ['Удалить', 'Delete'],
    'active': ['Активные', 'Active'],
    'completed': ['Выполнено', 'Completed'],
    'complete': ['Выполнить', 'Complete'],
    'snoozeLater': ['Напомнить позже', 'Remind later'],
    'repeat': ['Повтор', 'Repeat'],
    'starts': ['Начать', 'Start'],
    'ends': ['Завершить', 'End'],
    'emptyTitle': ['Здесь пока тихо', 'It’s quiet here'],
    'emptySub': [
      'Добавьте первое событие, чтобы история питомца начала наполняться',
      'Add the first event to start filling your pet’s story'
    ],
    'addEvent': ['Добавить событие', 'Add event'],
    'loadingTitle': ['Загружаем…', 'Loading…'],
    'loadingSub': ['Пожалуйста, подождите', 'Please wait a moment'],
    'errorTitle': ['Что-то пошло не так', 'Something went wrong'],
    'errorSub': [
      'Не удалось загрузить данные. Проверьте соединение и попробуйте снова',
      'We couldn’t load your data. Check your connection and try again'
    ],
    'retry': ['Попробовать снова', 'Try again'],
    'back': ['Назад', 'Back'],
    'offlineTitle': ['Нет соединения', 'No connection'],
    'offlineSub': [
      'Проверьте интернет и попробуйте снова',
      'Check your internet and try again'
    ],
    'retry2': ['Повторить', 'Retry'],
    'offlineMode': ['Офлайн-режим', 'Offline mode'],
    'profile': ['Профиль', 'Profile'],
    'account': ['Аккаунт', 'Account'],
    'language': ['Язык', 'Language'],
    'notifications': ['Уведомления', 'Notifications'],
    'sync': ['Синхронизация', 'Sync'],
    'backup': ['Резервное копирование', 'Backup'],
    'theme': ['Тема', 'Theme'],
    'themeTitle': ['Тема оформления', 'Appearance'],
    'themeLight': ['Светлая', 'Light'],
    'themeDark': ['Тёмная', 'Dark'],
    'themeSystem': ['Системная', 'System'],
    'units': ['Единицы измерения', 'Units'],
    'export': ['Экспорт', 'Export'],
    'dataMgmt': ['Управление данными', 'Data management'],
    'privacy': ['Приватность', 'Privacy'],
    'biometry': ['Биометрия', 'Biometrics'],
    'all': ['Все', 'All'],
    'search': ['Поиск', 'Search'],
    'slogan': [
      'Уютное место для хранения жизни питомца',
      'A cozy home for your pet’s whole life'
    ],
    'skip': ['Пропустить', 'Skip'],
    'next': ['Далее', 'Next'],
    'getStarted': ['Начать', 'Get started'],
    'welcomeTitle': ['Дневник питомца', 'Pet Diary'],
    'addFirstPet': ['Добавьте первого питомца', 'Add your first pet'],
    'createCopy': ['Создать копию сейчас', 'Back up now'],
    'restore': ['Восстановить из копии', 'Restore from backup'],
    'connect': ['Подключить Яндекс Диск', 'Connect Yandex Disk'],
    'connected': ['Подключён', 'Connected'],
    'notConnected': ['Не подключён', 'Not connected'],
    'autoBackup': ['Автоматически', 'Automatic'],
    'generate': ['Сформировать', 'Generate'],
  };

  static String s(String key, Lang lang) {
    final e = _t[key];
    if (e == null) return key;
    return lang == Lang.ru ? e[0] : e[1];
  }
}
