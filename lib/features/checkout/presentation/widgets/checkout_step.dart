import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class CheckoutStep extends StatelessWidget {
  final int stepNumber;
  final String title;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;
  final Widget? activeContent;
  final Widget? collapsedContent;

  const CheckoutStep({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.isCompleted,
    required this.isActive,
    this.isLast = false,
    this.activeContent,
    this.collapsedContent,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final primaryColor = context.mainColor;

    // Determine colors based on state
    Color indicatorBg;
    Color indicatorBorder;
    Widget indicatorChild;
    TextStyle titleStyle;

    if (isCompleted) {
      indicatorBg = primaryColor.withOpacity(0.1);
      indicatorBorder = primaryColor;
      indicatorChild = Icon(
        Icons.check_rounded,
        color: primaryColor,
        size: 16.sp,
      );
      titleStyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white70 : Colors.black87,
        fontFamily: 'Poppins',
      );
    } else if (isActive) {
      indicatorBg = primaryColor;
      indicatorBorder = primaryColor;
      indicatorChild = Text(
        stepNumber.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins',
        ),
      );
      titleStyle = TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: isDark ? Colors.white : Colors.black,
        fontFamily: 'Poppins',
      );
    } else {
      indicatorBg = isDark ? Colors.white10 : const Color(0xFFF3F4F6);
      indicatorBorder = isDark ? Colors.white12 : Colors.black12;
      indicatorChild = Text(
        stepNumber.toString(),
        style: TextStyle(
          color: isDark ? Colors.white38 : Colors.black38,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      );
      titleStyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white30 : Colors.black38,
        fontFamily: 'Poppins',
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step indicators & lines
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: indicatorBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: indicatorBorder, width: 1.5.w),
                ),
                child: Center(child: indicatorChild),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: isCompleted
                        ? primaryColor
                        : (isDark ? Colors.white10 : Colors.black.withOpacity(0.08)),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: titleStyle,
                    ),
                    if (isCompleted) ...[
                      SizedBox(width: 6.w),
                      Text(
                        "(Completed)",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 8.h),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
                    child: isActive
                        ? (activeContent ?? const SizedBox.shrink())
                        : (collapsedContent ?? const SizedBox.shrink()),
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
