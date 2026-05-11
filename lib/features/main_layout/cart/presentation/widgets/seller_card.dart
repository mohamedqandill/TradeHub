import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';

class SellerCard extends StatelessWidget {
  final CartResponseDTO group;
  final bool isSelected;
  final VoidCallback onTap;
  final int index;

  const SellerCard({
    super.key,
    required this.group,
    required this.isSelected,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.w,
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? (context.isDarkMode
                  ? context.mainColor.withOpacity(0.5)
                  : AppColors.mainColor)
              : (context.isDarkMode ? AppColors.lightBlack : Colors.white),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (context.isDarkMode
                    ? Colors.white10
                    : Colors.black.withOpacity(0.05)),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                group.logoUrl != null
                    ? CachedNetworkImage(
                        imageUrl: group.logoUrl!,
                        width: 50.w,
                        height: 50.w,
                        fit: BoxFit.fill,
                      )
                    : Icon(Icons.storefront_rounded,
                        size: 20.sp,
                        color: isSelected ? Colors.white : context.mainColor),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.2)
                        : context.mainColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    "SELLER",
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : context.mainColor,
                      letterSpacing: 0.5,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    group.companyName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: isSelected
                          ? Colors.white
                          : (context.isDarkMode ? Colors.white : AppColors.black),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "${group.items.length} ITEMS",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white.withOpacity(0.7)
                        : context.greyOrWhite.withOpacity(0.4),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (index * 100).ms)
        .slideX(begin: 0.2, end: 0);
  }
}
