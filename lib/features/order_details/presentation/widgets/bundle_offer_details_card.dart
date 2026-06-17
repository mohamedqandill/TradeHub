import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class BundleOfferDetailCard extends StatelessWidget {
  final dynamic bundle;
  final bool isDarkMode;
  final Color textColor;

  const BundleOfferDetailCard({
    required this.bundle,
    required this.isDarkMode,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final double savings =
        ((bundle.originalTotalPrice ?? 0) - (bundle.finalPrice ?? 0))
            .toDouble();
    final bool hasSavings = savings > 0;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isDarkMode
            ? context.mainColor.withOpacity(0.06)
            : context.mainColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.mainColor.withOpacity(0.18),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Bundle header ──────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon badge
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: context.mainColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.layers_rounded,
                      color: context.mainColor, size: 18.sp),
                ),
                SizedBox(width: 10.w),

                // Name + qty
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bundle.bundleName ?? "Bundle",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.06)
                              : Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "Qty: ${bundle.quantity}",
                          style: GoogleFonts.manrope(
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Pricing block
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (hasSavings) ...[
                      Text(
                        "${bundle.originalTotalPrice} EGP",
                        style: GoogleFonts.manrope(
                          color: AppColors.grey,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                    Text(
                      "${bundle.totalPrice} EGP",
                      style: GoogleFonts.manrope(
                        color: context.mainColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (hasSavings) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          "Save ${savings.toStringAsFixed(0)} EGP",
                          style: GoogleFonts.manrope(
                            color: Colors.green,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // ── Divider ────────────────────────────────────────────────
          if (bundle.products != null && bundle.products!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Divider(
                height: 1,
                thickness: 1,
                color: isDarkMode
                    ? context.mainColor.withOpacity(0.12)
                    : context.mainColor.withOpacity(0.10),
              ),
            ),

            // ── Products list inside bundle ────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: Column(
                children: (bundle.products as List).map<Widget>((product) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        // Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            width: 52.w,
                            height: 52.w,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.05)
                                  : AppColors.lightGrey.withOpacity(0.4),
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.08)
                                    : AppColors.lightGrey.withOpacity(0.6),
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.imageUrl ?? "",
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Icon(
                                Icons.image_not_supported_outlined,
                                size: 20.sp,
                                color: AppColors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),

                        // Name + price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.productName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: textColor,
                                        fontSize: 13.sp,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
                                  if (product.isGift == true) ...[
                                    SizedBox(width: 6.w),
                                    Icon(Icons.card_giftcard_rounded,
                                        color: Colors.amber.shade600,
                                        size: 14.sp),
                                  ],
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.white.withOpacity(0.05)
                                          : Colors.black.withOpacity(0.03),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      "x${product.quantity}",
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white70
                                            : Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${product.unitPrice} EGP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: context.mainColor,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
