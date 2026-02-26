import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

class AboutAppBody extends StatelessWidget {
  const AboutAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: context.mainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(20.w),
            child: Icon(
              Icons.storefront_rounded,
              size: 60.w,
              color: context.mainColor,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "TradeHub",
            style: context.base.theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 28.sp,
              color: context.isDarkMode ? AppColors.white : AppColors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            tr(LocaleKeys.empoweringLocalCommerce),
            style: context.base.theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16.sp,
              color: context.mainColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
              border: Border.all(
                color:
                    context.isDarkMode ? Colors.white12 : Colors.grey.shade100,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline_rounded,
                        color: Colors.amber, size: 28.sp),
                    SizedBox(width: 12.w),
                    Text(
                      tr(LocaleKeys.ourVision),
                      style: context.base.theme.textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: context.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  tr(LocaleKeys.appVisionDescription),
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15.sp,
                    height: 1.6,
                    color: context.isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            tr(LocaleKeys.version1),
            style: context.base.theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: context.isDarkMode ? Colors.white54 : Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
