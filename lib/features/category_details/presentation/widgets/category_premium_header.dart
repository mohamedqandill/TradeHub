import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class CategoryPremiumHeader extends StatelessWidget {
  final String categoryName;
  final int vendorCount;

  const CategoryPremiumHeader({
    super.key,
    required this.categoryName,
    required this.vendorCount,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final subtitleColor = isDark ? Colors.white54 : Colors.black54;

    final overline =
        isArabic ? 'تجار موثوقون' : 'VERIFIED PREMIUM VENDORS';
    final title = categoryName;
    final description = isArabic
        ? 'اكتشف أفضل المتاجر في $categoryName — تجار معتمدون يقدمون جودة فاخرة وخدمة موثوقة.'
        : 'Discover elite $categoryName boutiques — verified merchants delivering premium quality and trusted service.';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.04)
            : AppColors.lightGrey.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? Colors.white10 : AppColors.whiteGrey,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4.w,
            height: 72.h,
            margin: EdgeInsets.only(top: 4.h, right: isArabic ? 0 : 12.w, left: isArabic ? 12.w : 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.mainColor,
                  context.mainColor.withOpacity(0.35),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              gradient: AppColors.linearLight,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.mainColor.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.diamond_outlined,
              color: AppColors.white,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overline,
                  style: GoogleFonts.outfit(
                    color: context.mainColor,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: isArabic ? 0 : 1.4,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: textColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: isArabic ? 0 : -0.5,
                    height: 1.15,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: GoogleFonts.outfit(
                    color: subtitleColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    _HeaderChip(
                      icon: Icons.storefront_rounded,
                      label: '$vendorCount ${isArabic ? 'تاجر' : 'Vendors'}',
                      isDark: isDark,
                    ),
                    SizedBox(width: 8.w),
                    _HeaderChip(
                      icon: Icons.verified_user_rounded,
                      label: isArabic ? 'معتمد' : 'Verified',
                      isDark: isDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _HeaderChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.06)
            : AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? Colors.white12 : AppColors.whiteGrey,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: context.mainColor),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: isDark ? AppColors.white : AppColors.black,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
