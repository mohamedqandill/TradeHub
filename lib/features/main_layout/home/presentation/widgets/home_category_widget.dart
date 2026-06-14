import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;

    // Soft, eye-friendly backgrounds
    Color cardBgColor;
    Color borderColor;
    Color textColor;

    if (isDarkMode) {
      // Gentle, low-contrast dark translucent card
      cardBgColor = const Color(0xFF0F0F10);
      borderColor = Colors.white.withOpacity(0.06);
      textColor = Colors.white.withOpacity(0.9);
    } else {
      // Gentle, soft pastel tint of the mainColor (very easy on the eyes)
      cardBgColor = Color.lerp(context.mainColor, Colors.white, 0.94)!;
      borderColor = context.mainColor.withOpacity(0.12);
      textColor = Colors.black87;
    }

    return Column(
      children: [
        Container(
          width: 82.w,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Elegant white circular frame for the category image
              SizedBox(
                width: 60.w,
                height: 50.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    imageUrl: image,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Icon(
                      Icons.category_rounded,
                      color: context.mainColor,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ],
    );
  }
}
