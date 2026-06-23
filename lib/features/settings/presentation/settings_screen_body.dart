import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/shared_services/signalr_connection.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/settings/presentation/widgets/custom_settings_row_info.dart';
import 'package:tradehub/core/routes/routes.dart';

import '../../../core/localization/locale_keys.g.dart';

class SettingsScreenBody extends StatefulWidget {
  const SettingsScreenBody({super.key});

  @override
  State<SettingsScreenBody> createState() => _SettingsScreenBodyState();
}

class _SettingsScreenBodyState extends State<SettingsScreenBody> {
  static const _notifKey = 'notifications_enabled';

  late bool _notificationsEnabled;

  @override
  void initState() {
    super.initState();
    // Default to true if never saved before
    _notificationsEnabled =
        getIt<HiveStorageHelper>().getBool(_notifKey) ?? true;
  }

  Future<void> _onNotificationToggle(bool value) async {
    setState(() => _notificationsEnabled = value);
    await getIt<HiveStorageHelper>().saveBool(_notifKey, value);

    if (value) {
      await SignalRService().restart();
    } else {
      await SignalRService().stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = EasyLocalization.of(context)!.locale;
    List<String> titles = [
      LocaleKeys.accountInfo.tr(),
      LocaleKeys.savedAddresses.tr(),
      LocaleKeys.changePassword.tr(),
      LocaleKeys.notification.tr(),
      LocaleKeys.language.tr(),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0.sp),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Expanded(
            child: ListView.separated(
              itemCount: titles.length,
              separatorBuilder: (context, index) => SizedBox(height: 32.h),
              itemBuilder: (context, index) {
                return CustomSettingsRowInfo(
                  isArabic: locale.languageCode == AppConstants.ar,
                  title: titles[index],
                  index: index,
                  // Pass notification props only for the notifications row
                  notificationsEnabled:
                      index == 3 ? _notificationsEnabled : null,
                  onNotificationToggle:
                      index == 3 ? _onNotificationToggle : null,
                  onTapped: () {
                    if (index == 0) {
                      Navigator.pushNamed(context, Routes.accountInfo);
                    } else if (index == 1) {
                      Navigator.pushNamed(context, Routes.savedAddresses);
                    } else if (index == 2) {
                      Navigator.pushNamed(context, Routes.changePassword);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
