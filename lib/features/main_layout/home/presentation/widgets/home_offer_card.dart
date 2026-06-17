import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class HomeOfferCard extends StatelessWidget {
  const HomeOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.mainColor : context.mainColor,
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
            colors: context.isDarkMode
                ? [
                    AppColors.mainColor.withOpacity(0.9),
                    const Color.fromARGB(175, 0, 255, 136),
                  ]
                : [
                    const Color.fromARGB(220, 19, 105, 65),
                    const Color.fromARGB(255, 24, 79, 52).withOpacity(0.9),
                  ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: const [0, .4]),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        "Limited Offer",
                        style:
                            context.base.theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                // Title
                Text(
                  "Discover Our\nOffers!",
                  style: context.base.theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4.h),
                // Subtitle
                Text(
                  "Don't miss out on our exclusive deals",
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                // Button
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View Offers",
                        style:
                            context.base.theme.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.arrow_forward,
                          color: Colors.white, size: 14.sp),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Graphic side
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 35.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
