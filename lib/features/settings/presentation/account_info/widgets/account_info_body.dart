import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

import 'package:tradehub/features/settings/presentation/account_info/widgets/profile_image_widget.dart';
import 'package:tradehub/features/settings/presentation/account_info/widgets/info_card_widget.dart';

class AccountInfoBody extends StatefulWidget {
  const AccountInfoBody({super.key});

  @override
  State<AccountInfoBody> createState() => _AccountInfoBodyState();
}

class _AccountInfoBodyState extends State<AccountInfoBody> {
  String? savedAddress;

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  Future<void> _loadSavedAddress() async {
    await SharedPrefsHelper.init();
    setState(() {
      savedAddress = SharedPrefsHelper().getString(AppConstants.savedPlace);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ProfileImageWidget(),
          SizedBox(height: 40.h),
          InfoCardWidget(
            icon: Icons.person_outline_rounded,
            title: LocaleKeys.fullName.tr(),
            value: "Mohamed Qandil",
          ),
          SizedBox(height: 16.h),
          InfoCardWidget(
            icon: Icons.email_outlined,
            title: LocaleKeys.emailAddress.tr(),
            value: "mohamedqandil912@gmail.com",
          ),
          SizedBox(height: 16.h),
          InfoCardWidget(
            icon: Icons.location_on_outlined,
            title: LocaleKeys.savedAddresses.tr(),
            value: savedAddress ?? "--",
          ),
        ],
      ),
    );
  }
}
