import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withOpacity(0.35)
                : Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search vendors, products or categories...",
          hintStyle: TextStyle(
            color: (context.isDarkMode ? AppColors.whiteGrey : AppColors.grey)
                .withOpacity(0.65),
            fontSize: 14.sp,
          ),
          prefixIcon:
              Icon(Icons.search_rounded, color: context.mainColor, size: 22.sp),
          filled: true,
          fillColor: context.isDarkMode
              ? AppColors.lightBlack.withOpacity(0.6)
              : Colors.white,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: context.isDarkMode ? Colors.white12 : Colors.black12,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
