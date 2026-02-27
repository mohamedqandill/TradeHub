import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.lightBlack : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isDarkMode
                          ? AppColors.grey.withOpacity(0.3)
                          : AppColors.grey.withOpacity(0.1),
                    ),
                    image: DecorationImage(
                      image: AssetImage(Assets.images.karamelshaam.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Order Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Karam El-sham",
                        style:
                            context.base.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: context.mainColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        tr(LocaleKeys.delivered),
                        style: GoogleFonts.manrope(
                          color: Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "24 September 2023 16:17",
                        style: context.base.theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "${tr(LocaleKeys.orderId)}1284566612",
                        style: context.base.theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.grey,
                  size: 24.sp,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: isDarkMode
                ? AppColors.grey.withOpacity(0.3)
                : AppColors.grey.withOpacity(0.1),
          ),
          // Action Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.cached_outlined,
                        color: Colors.deepOrange,
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        tr(LocaleKeys.reOrder),
                        style:
                            context.base.theme.textTheme.labelLarge?.copyWith(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Colors.deepOrange,
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        tr(LocaleKeys.rateOrder),
                        style:
                            context.base.theme.textTheme.labelLarge?.copyWith(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
