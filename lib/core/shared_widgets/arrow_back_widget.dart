import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../colors/app_colors.dart';
import '../constants/app_constants.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40.w,
        height: 40.h,
        margin: context.locale.languageCode == AppConstants.en
            ? EdgeInsets.only(left: 20.sp)
            : EdgeInsets.only(right: 20.sp),
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: context.mainColor, shape: BoxShape.circle),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: context.isDarkMode ? AppColors.black : AppColors.white,
          ),
        ),
      ),
    );
  }
}
