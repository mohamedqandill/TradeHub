import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

import '../../../../../../Core/colors/app_colors.dart';

class CustomSocialContainer extends StatelessWidget {
  const CustomSocialContainer({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.grey : AppColors.white,
          border: Border.all(
              width: 1,
              color: context.isDarkMode
                  ? AppColors.mainDarkColor
                  : AppColors.mainColor),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Center(
            child: SvgWidget(
              assetName: icon,
              height: 30.h,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            context.isArabic
                ? "تسجيل الدخول باستخدام جوجل"
                : "Login with Google",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
