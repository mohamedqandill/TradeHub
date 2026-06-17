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
    final Color selectedBg = context.isDarkMode
        ? context.mainColor.withOpacity(0.4)
        : AppColors.mainColor;
    final Color unselectedBg =
        context.isDarkMode ? AppColors.lightBlack : Colors.white;

    final Color nameColor = isSelected
        ? Colors.white
        : (context.isDarkMode ? Colors.white : AppColors.black);
    final Color subColor =
        isSelected ? Colors.white.withOpacity(0.85) : AppColors.grey;

    final int itemCount = group.items?.length ?? 0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (context.isDarkMode
                    ? Colors.white10
                    : Colors.black.withOpacity(0.06)),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.mainColor.withOpacity(0.30),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Logo avatar ──
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : context.mainColor.withOpacity(0.08),
              ),
              child: ClipOval(
                child: group.logoUrl != null
                    ? CachedNetworkImage(
                        imageUrl: group.logoUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Icon(
                          Icons.storefront_rounded,
                          size: 18.sp,
                          color: isSelected ? Colors.white : context.mainColor,
                        ),
                      )
                    : Icon(
                        Icons.storefront_rounded,
                        size: 18.sp,
                        color: isSelected ? Colors.white : context.mainColor,
                      ),
              ),
            ),
            SizedBox(width: 10.w),
            // ── Name + item count ──
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 120.w),
                  child: Text(
                    group.companyName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: nameColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  "$itemCount items",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: subColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 80).ms).slideX(begin: 0.2, end: 0);
  }
}
