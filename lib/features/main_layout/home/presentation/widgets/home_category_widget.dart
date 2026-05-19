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

    return Container(
      width: 82.w,
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(18.r),
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
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: SizedBox(
              width: 44.w,
              height: 44.w,
              child: ClipOval(
                child: CachedNetworkImage(
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  imageUrl: image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(
                    Icons.category_rounded,
                    color: context.mainColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
