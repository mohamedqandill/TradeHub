import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';

class CustomOrderDetailsCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CustomOrderDetailsCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    Color cardColor =
        isDarkMode ? AppColors.black.withOpacity(0.3) : AppColors.white;

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.sp),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: child,
    );
  }
}
