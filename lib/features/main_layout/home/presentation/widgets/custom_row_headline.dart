import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

class CustomRowHeadline extends StatelessWidget {
  const CustomRowHeadline({
    super.key,
    required this.title,
    required this.subTitle,
    this.trailing,
  });

  final String title;
  final String subTitle; // Can act as a trailing CTA label (e.g. See All)
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';
    final bool isDarkMode = context.isDarkMode;

    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color subtitleColor = isDarkMode ? Colors.white54 : Colors.black54;

    // Creative, premium boutique titles and descriptive copywriting details
    String overlineTag = "";
    String displayTitle = title;
    String displayDescription = "";

    // Match exact section identifiers to attach elite overlines & titles
    if (title == LocaleKeys.categories.tr() || title.toLowerCase().contains("category") || title.contains("فئات")) {
      overlineTag = isArabic ? "تصفح المجموعات" : "EXPLORE COLLECTIONS";
      displayTitle = isArabic ? "أقسام المتجر" : "Boutique Categories";
      displayDescription = isArabic
          ? "اكتشف تشكيلات منسقة بعناية تلائم نمط حياتك الفريد"
          : "Find handpicked collections tailored for your elite lifestyle";
    } else if (title == LocaleKeys.featuredVendors.tr() || title.toLowerCase().contains("vendor") || title.toLowerCase().contains("merchant") || title.contains("تجار")) {
      overlineTag = isArabic ? "شركاء معتمدون" : "VERIFIED BOUTIQUE PARTNERS";
      displayTitle = isArabic ? "التجار المتميزون" : "Boutique Merchants";
      displayDescription = isArabic
          ? "تواصل مباشر وتسوق آمن من أفضل المتاجر الفاخرة الموثقة"
          : "Direct connection with verified premier boutiques and brands";
    } else if (title == LocaleKeys.popularProducts.tr() || title.toLowerCase().contains("product") || title.contains("منتج")) {
      overlineTag = isArabic ? "مختارات حصرية" : "EXCLUSIVELY CURATED FOR YOU";
      displayTitle = isArabic ? "روائع حصرية" : "Exclusive Masterpieces";
      displayDescription = isArabic
          ? "منتجات رائجة ذات جودة استثنائية منسقة خصيصًا لذوقك الرفيع"
          : "Highly trending premium products curated daily for your taste";
    } else {
      overlineTag = isArabic ? "تفاصيل إضافية" : "ADDITIONAL DETAILS";
      displayTitle = title;
      displayDescription = subTitle.isNotEmpty ? subTitle : "";
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Creative Vertical Accent Pillar (Visual Anchor)
          Container(
            width: 4.w,
            height: displayDescription.isNotEmpty ? 42.h : 22.h,
            margin: EdgeInsets.only(
              right: isArabic ? 0 : 10.w,
              left: isArabic ? 10.w : 0,
              top: 3.h,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.mainColor,
                  context.mainColor.withOpacity(0.4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: context.mainColor.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                )
              ],
            ),
          ),

          // 2. Elegant Title, Overline and Subtitle text block
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upper Spaced Tag Overline
                if (overlineTag.isNotEmpty)
                  Text(
                    overlineTag,
                    style: GoogleFonts.outfit(
                      color: context.mainColor,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: isArabic ? 0.0 : 1.6,
                    ),
                  ),
                SizedBox(height: 2.h),
                // Main Bold Display Title
                Text(
                  displayTitle,
                  style: GoogleFonts.outfit(
                    color: textColor,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: isArabic ? 0.0 : -0.6,
                    height: 1.15,
                  ),
                ),
                // Detailed Subtext Description
                if (displayDescription.isNotEmpty) ...[
                  SizedBox(height: 5.h),
                  Text(
                    displayDescription,
                    style: GoogleFonts.outfit(
                      color: subtitleColor.withOpacity(0.85),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (trailing != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: trailing!,
            ),

          // Trailing See All CTA button if needed
          if (subTitle.isNotEmpty && displayDescription != subTitle)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                subTitle,
                style: GoogleFonts.outfit(
                  color: subtitleColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
