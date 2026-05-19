import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/main_color.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';

class VendorInfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String rating;
  final String reviews;
  final String image;
  final String location;

  const VendorInfoCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;

    Color finalCardBg = isDarkMode ? const Color(0xFF0F0F10) : Colors.white;
    Color finalBorderColor = isDarkMode ? Colors.white.withOpacity(0.06) : AppColors.lightGrey.withOpacity(0.4);
    Color finalTextColor = isDarkMode ? AppColors.white : AppColors.black;
    Color finalSubtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: finalCardBg,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: finalBorderColor,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.35)
                : Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Logo Circular Frame
              Container(
                width: 68.w,
                height: 68.w,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? Colors.white24 : Colors.white,
                    width: 2.2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Icon(
                      Icons.storefront_rounded,
                      color: context.mainColor,
                      size: 30.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // 2. Business Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Store Business Type Tag
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: context.mainColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            subTitle.isNotEmpty ? subTitle : "Boutique",
                            style: GoogleFonts.outfit(
                              color: context.mainColor,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Verified badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_rounded,
                                color: Colors.green,
                                size: 10.sp,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                "Verified",
                                style: GoogleFonts.outfit(
                                  color: Colors.green,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: finalTextColor,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: context.mainColor,
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            location.isNotEmpty ? location : "Cairo, Egypt",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: finalSubtitleColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Divider(
            height: 1,
            thickness: 1,
            color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade100,
          ),
          SizedBox(height: 10.h),

          // Clean, high-legibility rating metadata line (Time and Delivery fully removed!)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    rating,
                    style: GoogleFonts.outfit(
                      color: finalTextColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    reviews,
                    style: GoogleFonts.outfit(
                      color: finalSubtitleColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.store_rounded,
                    color: context.mainColor,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "Premium Boutique",
                    style: GoogleFonts.outfit(
                      color: context.mainColor,
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
