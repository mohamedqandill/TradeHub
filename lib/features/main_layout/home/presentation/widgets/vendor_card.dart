import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_company_entity.dart';

class VendorCard extends StatefulWidget {
  final GetCompanyEntity? vendor;

  const VendorCard({super.key, this.vendor});

  @override
  State<VendorCard> createState() => _VendorCardState();
}

class _VendorCardState extends State<VendorCard> {
  Color? _extractedColor;
  bool _isColorExtracted = false;

  @override
  void initState() {
    super.initState();
    _extractColor();
  }

  @override
  void didUpdateWidget(VendorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.vendor?.logoUrl != widget.vendor?.logoUrl) {
      _extractColor();
    }
  }

  Future<void> _extractColor() async {
    final logoUrl = widget.vendor?.logoUrl;
    if (logoUrl == null || logoUrl.isEmpty) return;

    try {
      final ImageProvider imageProvider = CachedNetworkImageProvider(logoUrl);
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        imageProvider,
        maximumColorCount: 8,
      );

      final Color? baseColor = paletteGenerator.dominantColor?.color ??
          paletteGenerator.vibrantColor?.color ??
          paletteGenerator.mutedColor?.color;

      if (baseColor != null && mounted) {
        setState(() {
          _extractedColor = baseColor;
          _isColorExtracted = true;
        });
      }
    } catch (e) {
      // Fallback gracefully on errors
    }
  }

  // Dynamic senior category icon mapper
  IconData _getCategoryIcon(String? categoryName) {
    if (categoryName == null) return Icons.storefront_rounded;
    final name = categoryName.toLowerCase();
    if (name.contains('furniture') || name.contains('home')) {
      return Icons.chair_alt_rounded;
    }
    if (name.contains('tech') ||
        name.contains('electronic') ||
        name.contains('phone') ||
        name.contains('gadget')) {
      return Icons.devices_rounded;
    }
    if (name.contains('fashion') ||
        name.contains('cloth') ||
        name.contains('wear') ||
        name.contains('apparel')) {
      return Icons.checkroom_rounded;
    }
    if (name.contains('food') ||
        name.contains('restaurant') ||
        name.contains('cafe') ||
        name.contains('grocery')) {
      return Icons.restaurant_rounded;
    }
    if (name.contains('book')) return Icons.menu_book_rounded;
    if (name.contains('sport') || name.contains('gym')) {
      return Icons.sports_gymnastics_rounded;
    }
    return Icons.store_rounded;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;

    // Dynamic brand accent color from logo palette
    Color brandAccentColor = context.mainColor;
    if (_isColorExtracted && _extractedColor != null) {
      if (isDarkMode) {
        brandAccentColor = Color.lerp(_extractedColor, Colors.white, 0.40)!;
      } else {
        brandAccentColor = Color.lerp(_extractedColor, Colors.black, 0.25)!;
      }
    }

    // Suited, premium branded card backgrounds
    Color finalCardBg = isDarkMode ? const Color(0xFF0A0A0B) : AppColors.white;
    Color finalBorderColor = isDarkMode
        ? Colors.white.withOpacity(0.06)
        : AppColors.lightGrey.withOpacity(0.8);
    Color finalTextColor = isDarkMode ? AppColors.white : AppColors.black;
    Color finalSubtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.vendorProfile,
        arguments: widget.vendor?.id,
      ),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 250.w,
        decoration: BoxDecoration(
          color: finalCardBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: finalBorderColor,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP HEADER BANNER (Full bleed image takes all width)
            Stack(
              children: [
                Container(
                  height: 115.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.03)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(19.r),
                      topRight: Radius.circular(19.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(19.r),
                      topRight: Radius.circular(19.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.vendor?.logoUrl ?? "",
                      fit: BoxFit
                          .cover, // Full bleed layout takes all width and height
                      alignment: Alignment.center,
                      errorWidget: (context, url, error) => Container(
                        color: brandAccentColor.withOpacity(0.08),
                        child: Icon(
                          Icons.storefront_rounded,
                          color: brandAccentColor,
                          size: 32.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                // "Verified" floating tag overlay on top left
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 11.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Verified",
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 2. STORE INFO SECTION (Under image)
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Store Name
                      Expanded(
                        child: Text(
                          widget.vendor?.businessName ?? "Premium Store",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            color: finalTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      // Rating Star Badge
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 13.sp,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            "4.9",
                            style: GoogleFonts.outfit(
                              color: finalTextColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  // Location Row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: brandAccentColor,
                        size: 11.sp,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          widget.vendor?.locationName ?? "Cairo, Egypt",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            color: finalSubtitleColor,
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.06)
                        : Colors.grey.shade100,
                  ),
                  SizedBox(height: 10.h),
                  // Category Tag and Visit Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Category Tag
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: brandAccentColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getCategoryIcon(widget.vendor?.businessTypeName),
                              color: brandAccentColor,
                              size: 12.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              widget.vendor?.businessTypeName ?? "Retail",
                              style: GoogleFonts.outfit(
                                color: brandAccentColor,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Visit CTA Link
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Visit Store",
                            style: GoogleFonts.outfit(
                              color: brandAccentColor,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: brandAccentColor,
                            size: 13.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
