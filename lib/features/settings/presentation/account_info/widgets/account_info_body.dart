import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tradehub/features/settings/presentation/account_info/widgets/profile_image_widget.dart';
import 'package:tradehub/features/settings/presentation/account_info/widgets/info_card_widget.dart';

class AccountInfoBody extends StatelessWidget {
  const AccountInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ProfileImageWidget(),
          SizedBox(height: 40.h),
          const InfoCardWidget(
            icon: Icons.person_outline_rounded,
            title: "Full Name",
            value: "Mohamed Qandil",
          ),
          SizedBox(height: 16.h),
          const InfoCardWidget(
            icon: Icons.email_outlined,
            title: "Email Address",
            value: "mohamedqandil912@gmail.com",
          ),
        ],
      ),
    );
  }
}
