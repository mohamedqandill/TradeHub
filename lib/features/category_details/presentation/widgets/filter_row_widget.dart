import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

class FilterRowWidget extends StatelessWidget {
  const FilterRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      LocaleKeys.all.tr(),
      LocaleKeys.topRated.tr(),
      LocaleKeys.nearest.tr(),
      LocaleKeys.openNow.tr(),
      LocaleKeys.new_filter.tr()
    ];
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.mainColor
                  : (context.isDarkMode
                      ? AppColors.black.withOpacity(0.3)
                      : AppColors.lightGrey),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: isSelected ? context.mainColor : Colors.transparent,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              filters[index],
              style: TextStyle(
                color: isSelected
                    ? (context.isDarkMode ? AppColors.black : AppColors.white)
                    : (context.isDarkMode ? AppColors.white : AppColors.black),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }
}
