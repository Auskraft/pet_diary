import 'package:flutter/material.dart';

import '../../core/app_icons.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_text.dart';
import '../../logic/locale_cubit.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/page_scaffold.dart';

enum BackupState { idle, syncing, success, error, offline }

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});
  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  BackupState state = BackupState.idle;
  bool connected = true;
  bool auto = true;
  int freq = 0; // 0 daily, 1 weekly

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;

    return PageScaffold(
      title: AppStrings.s('backup', lang),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // demo state switcher
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final s in BackupState.values) ...[
                  AppChip(
                    label: _stateLabel(s, lang),
                    selected: state == s,
                    onTap: () => setState(() => state = s),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          _StatusBanner(state: state, lang: lang),
          const SizedBox(height: 16),
          AppCard(
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: c.sageSoft,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                  child: Icon(appIcon('cloud'), color: c.sageDeep, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Яндекс Диск',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15)),
                      const SizedBox(height: 2),
                      Text(
                        connected
                            ? AppStrings.s('connected', lang)
                            : AppStrings.s('notConnected', lang),
                        style: AppText.caption(
                            color: connected ? c.sageDeep : c.ink3),
                      ),
                    ],
                  ),
                ),
                if (connected)
                  Icon(appIcon('checkCircle'), color: c.sageDeep, size: 22)
                else
                  AppButton(
                    label: AppStrings.s('connect', lang),
                    expand: false,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const OAuthScreen()),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lang.pick('Последняя копия', 'Last backup'),
                              style: AppText.caption(color: c.ink3)),
                          const SizedBox(height: 2),
                          Text(
                              '${lang.pick('Сегодня в 14:30', 'Today at 2:30 PM')} · 128 ${lang.pick('МБ', 'MB')}',
                              style: AppText.cardTitle(color: c.ink)),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 24, color: c.line),
                Row(
                  children: [
                    Expanded(
                      child: Text(AppStrings.s('autoBackup', lang),
                          style: AppText.cardTitle(color: c.ink)),
                    ),
                    AppToggle(
                        value: auto, onChanged: (v) => setState(() => auto = v)),
                  ],
                ),
                if (auto) ...[
                  const SizedBox(height: 12),
                  AppSegment(
                    options: [
                      lang.pick('Ежедневно', 'Daily'),
                      lang.pick('Еженедельно', 'Weekly'),
                    ],
                    index: freq,
                    onChanged: (i) => setState(() => freq = i),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            color: c.bg2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang.pick('В копию входит', 'Backup includes'),
                    style: AppText.caption(color: c.ink3)),
                const SizedBox(height: 8),
                for (final item in [
                  lang.pick('Профили питомцев', 'Pet profiles'),
                  lang.pick('События', 'Events'),
                  lang.pick('Фото', 'Photos'),
                  lang.pick('Документы', 'Documents'),
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Icon(appIcon('check'), size: 16, color: c.sageDeep),
                        const SizedBox(width: 8),
                        Text(item, style: AppText.body(color: c.ink2)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          AppButton(
            label: AppStrings.s('createCopy', lang),
            icon: appIcon('uploadCloud'),
            onPressed: () => setState(() => state = BackupState.syncing),
          ),
          const SizedBox(height: 10),
          AppButton(
            label: AppStrings.s('restore', lang),
            variant: AppButtonVariant.secondary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  String _stateLabel(BackupState s, Lang lang) => switch (s) {
        BackupState.idle => lang.pick('Готово', 'Idle'),
        BackupState.syncing => lang.pick('Синхрон.', 'Syncing'),
        BackupState.success => lang.pick('Успех', 'Success'),
        BackupState.error => lang.pick('Ошибка', 'Error'),
        BackupState.offline => lang.pick('Офлайн', 'Offline'),
      };
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.state, required this.lang});
  final BackupState state;
  final Lang lang;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (tint, icon, title, sub) = switch (state) {
      BackupState.idle => (
          'sage',
          'checkCircle',
          lang.pick('Всё сохранено', 'Everything is backed up'),
          lang.pick('Данные в безопасности', 'Your data is safe'),
        ),
      BackupState.syncing => (
          'blue',
          'uploadCloud',
          lang.pick('Синхронизация…', 'Syncing…'),
          lang.pick('Загружаем копию на Яндекс Диск', 'Uploading to Yandex Disk'),
        ),
      BackupState.success => (
          'sage',
          'checkCircle',
          lang.pick('Копия создана', 'Backup complete'),
          lang.pick('Сегодня в 14:30', 'Today at 2:30 PM'),
        ),
      BackupState.error => (
          'peach',
          'x',
          AppStrings.s('errorTitle', lang),
          lang.pick('Не удалось создать копию', 'Couldn’t create a backup'),
        ),
      BackupState.offline => (
          'beige',
          'wifiOff',
          AppStrings.s('offlineTitle', lang),
          AppStrings.s('offlineSub', lang),
        ),
    };

    return AppCard(
      color: c.tintSoft(tint),
      child: Row(
        children: [
          Icon(appIcon(icon), color: c.tintDeep(tint), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.cardTitle(color: c.ink)),
                const SizedBox(height: 2),
                Text(sub, style: AppText.caption(color: c.ink2)),
              ],
            ),
          ),
          if (state == BackupState.syncing)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2.4, color: c.blueDeep),
            ),
        ],
      ),
    );
  }
}

class OAuthScreen extends StatelessWidget {
  const OAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lang = context.lang;
    return PageScaffold(
      title: lang.pick('Подключение', 'Connect'),
      scroll: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 84,
            height: 84,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: c.sageSoft, shape: BoxShape.circle),
            child: Icon(appIcon('cloud'), color: c.sageDeep, size: 40),
          ),
          const SizedBox(height: 18),
          Text(lang.pick('Войдите в Яндекс', 'Sign in to Yandex'),
              style: AppText.screenTitle(color: c.ink)),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              lang.pick(
                  'Разрешите доступ к Яндекс Диску, чтобы хранить резервные копии',
                  'Allow access to Yandex Disk to store your backups'),
              textAlign: TextAlign.center,
              style: AppText.body(color: c.ink2),
            ),
          ),
          const Spacer(),
          AppButton(
            label: lang.pick('Разрешить доступ', 'Allow access'),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(height: 10),
          AppButton(
            label: AppStrings.s('cancel', lang),
            variant: AppButtonVariant.secondary,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }
}
