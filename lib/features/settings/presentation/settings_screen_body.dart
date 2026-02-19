import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/features/settings/presentation/widgets/custom_settings_row_info.dart';

import '../../../core/localization/locale_keys.g.dart';

class SettingsScreenBody extends StatefulWidget {
  const SettingsScreenBody({super.key});

  @override
  State<SettingsScreenBody> createState() => _SettingsScreenBodyState();
}

class _SettingsScreenBodyState extends State<SettingsScreenBody> {
  @override
  Widget build(BuildContext context) {
    final locale = EasyLocalization.of(context)!.locale;
    List<String> titles = [
      LocaleKeys.accountInfo.tr(),
      LocaleKeys.savedAddresses.tr(),
      LocaleKeys.changeEmail.tr(),
      LocaleKeys.changePassword.tr(),
      LocaleKeys.notification.tr(),
      LocaleKeys.language.tr(),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0.sp),
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return CustomSettingsRowInfo(
                      isArabic: locale.languageCode == AppConstants.ar,
                      title: titles[index],
                      onTapped: () {},
                      index: index);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 32.h,
                  );
                },
                itemCount: titles.length),
          )
        ],
      ),
    );
  }
}
