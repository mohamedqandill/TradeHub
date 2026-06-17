import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/order_details/presentation/order_details_args.dart';
import 'package:tradehub/features/your_orders/data/models/order_response_d_t_o.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderDataResponseDTO order;
  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;

    Color cardBgColor = isDarkMode ? const Color(0xFF0A0A0B) : AppColors.white;
    Color borderColor = isDarkMode
        ? Colors.white.withOpacity(0.06)
        : AppColors.lightGrey.withOpacity(0.8);
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    Color subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    final bool hasBundles =
        order.bundleItems != null && order.bundleItems!.isNotEmpty;
    final bool hasItems = order.items != null && order.items!.isNotEmpty;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.orderDetails,
          arguments: OrderDetailsArgs(orderId: order.id ?? 0),
        );
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.04),
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. HEADER: Order ID + Date ──────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long_rounded,
                          color: context.mainColor, size: 15.sp),
                      SizedBox(width: 6.w),
                      Text(
                        "#TRD-${order.id}",
                        style: GoogleFonts.shareTechMono(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time_filled_rounded,
                          color: subtitleColor.withOpacity(0.6), size: 13.sp),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDate(order.createdAt),
                        style: GoogleFonts.manrope(
                          color: subtitleColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(
                height: 1,
                thickness: 1,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade100,
              ),
            ),

            // ── 2. STORE + STATUS ───────────────────────────────────────
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white12 : Colors.grey.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: isDarkMode ? Colors.white24 : Colors.white,
                          width: 1.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: order.companyLogo ?? "",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.store_rounded, color: context.mainColor),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.companyName ?? "Premium Partner",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 15.sp,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.local_shipping_rounded,
                                color: isDarkMode
                                    ? Colors.white38
                                    : Colors.black38,
                                size: 13.sp),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                order.address ?? "No delivery address logged",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: subtitleColor,
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
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: _getStatusBgColor(order.orderStatus),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            color: _getStatusColor(order.orderStatus),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          order.orderStatus ?? "Unknown",
                          style: GoogleFonts.manrope(
                            color: _getStatusColor(order.orderStatus),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── 3. REGULAR ITEMS ────────────────────────────────────────
            if (hasItems) ...[
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.03)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.04)
                          : Colors.grey.shade100,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Wrap(
                        spacing: 8.w,
                        children: order.items!.take(3).map((item) {
                          return Row(
                            children: [
                              Container(
                                width: 38.w,
                                height: 38.w,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white10
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: isDarkMode
                                        ? Colors.white24
                                        : Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7.r),
                                  child: CachedNetworkImage(
                                    imageUrl: item.imageUrl ?? "",
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) => Icon(
                                        Icons.image_outlined,
                                        size: 14.sp,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName ?? "",
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      "x${item.quantity}",
                                      style: TextStyle(
                                        color: context.mainColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      if (order.items!.length > 3) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: context.mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Text(
                            "+${order.items!.length - 3} more",
                            style: TextStyle(
                              color: context.mainColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: order.items!.map(
                            (item) {
                              int totalPrice = 0;
                              for (int i = 0; i < order.items!.length; i++) {
                                totalPrice = totalPrice +
                                    (order.items![i].price! *
                                            order.items![i].quantity!.toInt())
                                        .toInt();
                              }
                              return Column(
                                children: [
                                  Text(
                                    "${order.items!.length} ${order.items!.length == 1 ? "item" : "items"}",
                                    style: GoogleFonts.manrope(
                                      color: subtitleColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "$totalPrice EGP",
                                    style: GoogleFonts.manrope(
                                      color: textColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList()),
                    ],
                  ),
                ),
              ),
            ],

            // ── 4. BUNDLE OFFER ITEMS ───────────────────────────────────
            if (hasBundles) ...[
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section label
                    Row(
                      children: [
                        Icon(Icons.local_offer_rounded,
                            color: context.mainColor, size: 13.sp),
                        SizedBox(width: 5.w),
                        Text(
                          "Bundle Offers",
                          style: GoogleFonts.manrope(
                            color: context.mainColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    ...order.bundleItems!
                        .map((bundle) => _BundleOfferCard(
                              bundle: bundle,
                              isDarkMode: isDarkMode,
                              textColor: textColor,
                              subtitleColor: subtitleColor,
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],

            // ── 5. FOOTER: Payment + Total ──────────────────────────────
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        order.paymentStatus == "Paid"
                            ? Icons.check_circle_outline_rounded
                            : Icons.pending_actions_rounded,
                        color: order.paymentStatus == "Paid"
                            ? Colors.green
                            : Colors.orange,
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        order.paymentStatus ?? "Unpaid",
                        style: GoogleFonts.manrope(
                          color: order.paymentStatus == "Paid"
                              ? Colors.green
                              : Colors.orange,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${tr(LocaleKeys.total)}: ",
                        style: GoogleFonts.manrope(
                          color: subtitleColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${order.total} EGP",
                        style: GoogleFonts.manrope(
                          color: context.mainColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                        ),
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

  Color _getStatusBgColor(String? status) {
    switch (status) {
      case "Delivered":
        return Colors.green.withOpacity(0.12);
      case "AwaitingPayment":
        return Colors.orange.withOpacity(0.12);
      case "Processing":
        return Colors.blue.withOpacity(0.12);
      default:
        return Colors.grey.withOpacity(0.12);
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Confirmed":
        return Colors.green;
      case "AwaitingPayment":
        return Colors.orange;
      case "Processing":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "";
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }
}

// ── Bundle Offer Card ────────────────────────────────────────────────────────

class _BundleOfferCard extends StatelessWidget {
  final dynamic bundle;
  final bool isDarkMode;
  final Color textColor;
  final Color subtitleColor;

  const _BundleOfferCard({
    required this.bundle,
    required this.isDarkMode,
    required this.textColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final int savings =
        (bundle.originalTotalPrice ?? 0) - (bundle.finalPrice ?? 0);
    final bool hasSavings = savings > 0;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isDarkMode
            ? context.mainColor.withOpacity(0.06)
            : context.mainColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: context.mainColor.withOpacity(0.18),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bundle Header Row
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 8.h),
            child: Row(
              children: [
                // Bundle icon badge
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: context.mainColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.layers_rounded,
                      color: context.mainColor, size: 15.sp),
                ),
                SizedBox(width: 8.w),

                // Bundle name + quantity
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
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "x${bundle.quantity}",
                        style: GoogleFonts.manrope(
                          color: subtitleColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Pricing column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (hasSavings)
                      Text(
                        "${bundle.originalTotalPrice} EGP",
                        style: GoogleFonts.manrope(
                          color: subtitleColor.withOpacity(0.6),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Text(
                      "${bundle.totalPrice} EGP",
                      style: GoogleFonts.manrope(
                        color: context.mainColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (hasSavings)
                      Container(
                        margin: EdgeInsets.only(top: 2.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          "Save ${savings.toStringAsFixed(0)} EGP",
                          style: GoogleFonts.manrope(
                            color: Colors.green,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Products inside the bundle
          if (bundle.products != null && bundle.products!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 10.h),
              child: Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: (bundle.products as List).map<Widget>((product) {
                  return _BundleProductChip(
                    product: product,
                    isDarkMode: isDarkMode,
                    subtitleColor: subtitleColor,
                    textColor: textColor,
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

// ── Bundle Product Chip ──────────────────────────────────────────────────────

class _BundleProductChip extends StatelessWidget {
  final dynamic product;
  final bool isDarkMode;
  final Color subtitleColor;
  final Color textColor;

  const _BundleProductChip({
    required this.product,
    required this.isDarkMode,
    required this.subtitleColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.08)
              : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl ?? "",
              width: 28.w,
              height: 28.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                width: 28.w,
                height: 28.w,
                color: isDarkMode ? Colors.white10 : Colors.grey.shade100,
                child:
                    Icon(Icons.image_outlined, size: 14.sp, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 7.w),

          // Name + price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  color: textColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    "x${product.quantity}",
                    style: GoogleFonts.manrope(
                      color: subtitleColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (product.unitPrice != null) ...[
                    Text(
                      "  ·  ${product.unitPrice} EGP",
                      style: GoogleFonts.manrope(
                        color: subtitleColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  if (product.isGift == true) ...[
                    SizedBox(width: 4.w),
                    Icon(Icons.card_giftcard_rounded,
                        color: Colors.amber.shade600, size: 11.sp),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
