import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/services/master_key.dart';
import 'package:flyssh/services/settings.dart';
import 'package:flyssh/services/token.dart';
import 'package:flyssh/theme/color_theme.dart';
import 'package:flyssh/widgets/confirm_dialog.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsService _settingsService = getIt<SettingsService>();

  @override
  void initState() {
    super.initState();
    _settingsService.addListener(_onSettingsChanged);
  }

  void _onSettingsChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _settingsService.removeListener(_onSettingsChanged);
    super.dispose();
  }

  Future<void> _logout() async {
    final confirm = await showConfirmDialog(
      context: context,
      title: "Logout",
      message: "Are you sure you want to log out?",
      confirmLabel: "Logout",
      destructive: false,
    );
    if (confirm != true) return;
    await getIt<TokenService>().clearToken();
    await getIt<MasterKeyService>().clearMasterKey();
    if (mounted) {
      context.go('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "Settings",
      maxContentWidth: 600,
      body: ListView(
        padding: EdgeInsets.all(BASE_SPACE * 4),
        children: [
          Text("Theme Mode",
              style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: BASE_SPACE * 2),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text("System"),
                icon: Icon(Icons.settings_suggest),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text("Light"),
                icon: Icon(Icons.light_mode),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text("Dark"),
                icon: Icon(Icons.dark_mode),
              ),
            ],
            selected: {_settingsService.themeMode},
            onSelectionChanged: (modes) {
              _settingsService.setThemeMode(modes.first);
            },
          ),
          SizedBox(height: BASE_SPACE * 6),
          Text("Color Theme",
              style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: BASE_SPACE * 2),
          Wrap(
            spacing: BASE_SPACE * 3,
            runSpacing: BASE_SPACE * 3,
            children: ColorThemes.all.map((theme) {
              final isSelected =
                  theme.name == _settingsService.colorTheme.name;
              return GestureDetector(
                onTap: () => _settingsService.setColorTheme(theme),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: theme.primary,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(
                            color:
                                Theme.of(context).colorScheme.onSurface,
                            width: 2.5,
                          )
                        : Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: theme.onPrimary,
                          size: 16,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: BASE_SPACE * 8),
          FButton(
            variant: FButtonVariant.destructive,
            onPress: _logout,
            prefix: Icon(Icons.logout),
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
