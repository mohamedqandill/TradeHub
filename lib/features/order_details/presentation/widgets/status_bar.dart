import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

Widget buildStatusStepper(BuildContext context, String status) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    final normalizedStatus = status.toLowerCase();

    if (normalizedStatus == 'cancelled') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.cancel_rounded, color: Colors.red, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              "This order has been cancelled",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp),
            ),
          ],
        ),
      );
    }

    int activeIndex = 0;
    if (normalizedStatus == 'confirmed') activeIndex = 1;
    if (normalizedStatus == 'delivered') activeIndex = 2;

    final steps = ['Placed', 'Confirmed', 'Delivered'];

    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= activeIndex;
        final isActive = index == activeIndex;
        final stepColor = isCompleted
            ? context.mainColor
            : (isDarkMode ? Colors.white24 : Colors.black12);

        return Expanded(
          child: Row(
            children: [
              Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? stepColor : Colors.transparent,
                  border: Border.all(color: stepColor, width: 2.sp),
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(Icons.check_rounded,
                          size: 12.sp, color: Colors.white)
                      : Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white60
                                : Colors.black54,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                steps[index],
                style: TextStyle(
                  color: isActive
                      ? textColor
                      : (isCompleted
                          ? textColor.withOpacity(0.8)
                          : AppColors.grey),
                  fontSize: 11.sp,
                  fontWeight:
                      isActive ? FontWeight.w900 : FontWeight.w600,
                ),
              ),
              if (index < steps.length - 1)
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    height: 2.h,
                    color: index < activeIndex
                        ? context.mainColor
                        : (isDarkMode
                            ? Colors.white10
                            : Colors.black.withOpacity(0.05)),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }