import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';

class VendorSearchBar extends StatelessWidget {
  const VendorSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search your favorite items",
          hintStyle: TextStyle(
            color: AppColors.grey.withOpacity(0.6),
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.grey, size: 24.sp),
          filled: true,
          fillColor: context.isDarkMode
              ? AppColors.lightBlack
              : AppColors.lightGrey.withOpacity(0.5),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
