import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/features/settings/presentation/settings_screen_body.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: tr(LocaleKeys.settings),
        enableLeading: true,
      ),
      body: const SettingsScreenBody(),
    );
  }
}
