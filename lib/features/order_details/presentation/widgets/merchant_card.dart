import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';
import 'package:tradehub/features/order_details/presentation/widgets/bundle_offer_details_card.dart';
import 'package:tradehub/features/order_details/presentation/widgets/custom_order_details_card.dart';

Widget buildItemsAndMerchantCard(
    BuildContext context, OrderDetailsResponseDTO order) {
  bool isDarkMode = context.isDarkMode;
  Color textColor = isDarkMode ? AppColors.white : AppColors.black;

  final bool hasBundles =
      order.bundleItems != null && order.bundleItems!.isNotEmpty;

  return CustomOrderDetailsCard(
    padding: EdgeInsets.all(18.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Merchant header ──────────────────────────────────────────
        Row(
          children: [
            Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.03)
                    : AppColors.lightGrey.withOpacity(0.4),
                border: Border.all(
                    color: isDarkMode ? Colors.white12 : AppColors.lightGrey,
                    width: 1),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: order.companyLogo,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Icon(
                      Icons.storefront_rounded,
                      color: AppColors.grey.withOpacity(0.7),
                      size: 20.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          order.companyName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.sp,
                            color: textColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "MERCHANT",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w900,
                            fontSize: 8.sp,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Official Verified TradeHub Seller Partner",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Divider(
            color: isDarkMode
                ? Colors.white.withOpacity(0.06)
                : AppColors.lightGrey.withOpacity(0.6),
            height: 1,
          ),
        ),

        // ── Regular items header ─────────────────────────────────────
        if (order.items.isNotEmpty) ...[
          Row(
            children: [
              Icon(Icons.shopping_bag_outlined,
                  size: 20.sp, color: context.mainColor),
              SizedBox(width: 8.w),
              Text(
                "${LocaleKeys.items.tr()} (${order.items.length})",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Divider(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.06)
                    : AppColors.lightGrey.withOpacity(0.6),
                height: 1,
              ),
            ),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      width: 75.w,
                      height: 75.h,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.02)
                            : AppColors.lightGrey.withOpacity(0.4),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.06)
                              : AppColors.lightGrey.withOpacity(0.6),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported_outlined,
                            size: 24.sp,
                            color: AppColors.grey.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: textColor,
                            fontSize: 14.sp,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (item.options != null &&
                            item.options!.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Wrap(
                            spacing: 4.w,
                            children: item.options!.map((opt) {
                              final isLast = item.options!.last == opt;
                              return Text(
                                "${opt.optionName}: ${opt.valueName}${isLast ? "" : "  •"}",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.black.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                "${LocaleKeys.qty.tr()}: ${item.quantity}",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            Text(
                              "${item.price} EGP",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: context.mainColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],

        // ── Bundle Offers section ────────────────────────────────────
        if (hasBundles) ...[
          if (order.items.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Divider(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.06)
                    : AppColors.lightGrey.withOpacity(0.6),
                height: 1,
              ),
            ),
          ],

          // Section header
          Row(
            children: [
              Icon(Icons.local_offer_rounded,
                  size: 20.sp, color: context.mainColor),
              SizedBox(width: 8.w),
              Text(
                "Bundle Offers (${order.bundleItems!.length})",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // One card per bundle
          ...order.bundleItems!.map(
            (bundle) => BundleOfferDetailCard(
              bundle: bundle,
              isDarkMode: isDarkMode,
              textColor: textColor,
            ),
          ),
        ],
      ],
    ),
  );
}
