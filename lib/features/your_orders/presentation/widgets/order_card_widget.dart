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

    // Premium Color System matching the Pandora obsidian-black and pure white aesthetics
    Color cardBgColor = isDarkMode ? const Color(0xFF0A0A0B) : AppColors.white;
    Color borderColor = isDarkMode
        ? Colors.white.withOpacity(0.06)
        : AppColors.lightGrey.withOpacity(0.8);
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    Color subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.orderDetails,
          arguments: OrderDetailsArgs(
            orderId: order.id ?? 0,
          ),
        );
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: borderColor,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.03),
              offset: const Offset(0, 6),
              blurRadius: 16,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP HEADER BANNER: Order ID, Clock Icon & Date
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Monospaced Order ID Tag
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long_rounded,
                        color: context.mainColor,
                        size: 15.sp,
                      ),
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
                  // Time stamp & clock indicator
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: subtitleColor.withOpacity(0.6),
                        size: 13.sp,
                      ),
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

            // Subtle divider line
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

            // 2. MAIN HUB SECTION: Store Profile, Shipping Address & Dynamic Status Pill
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dynamic Circular Logo with beautiful border
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white12 : Colors.grey.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDarkMode ? Colors.white24 : Colors.white,
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: order.companyLogo ?? "",
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => Icon(
                          Icons.store_rounded,
                          color: context.mainColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Store identity & Address details
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
                        // Shipping Address with Pin
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping_rounded,
                              color:
                                  isDarkMode ? Colors.white38 : Colors.black38,
                              size: 13.sp,
                            ),
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

                  // Dynamic Glowing Status Indicator
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
                        // Pulse glowing dot
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

            // 3. PRODUCT PREVIEW SECTION: Horizontal images of purchased items
            if (order.items != null && order.items!.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
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
                      // Horizontal items thumbnails (up to 3 previews)
                      Wrap(
                        spacing: 8.w,
                        children: order.items!.take(3).map((item) {
                          return Container(
                            width: 38.w,
                            height: 38.w,
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.white10 : Colors.white,
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
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_outlined,
                                  size: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      if (order.items!.length > 3) ...[
                        SizedBox(width: 8.w),
                        // "+N more items" pill
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
                      // Billing Summary
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                          Row(
                            children: [
                              Text(
                                "${order.total} EGP",
                                style: GoogleFonts.manrope(
                                  color: textColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // 4. TRANSACTION BILL SLIP FOOTER: Price and payment status
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Payment Status indicator
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
                  // Total details label
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

            // Divider Line
            Divider(
              height: 1,
              thickness: 1.2,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.06)
                  : AppColors.lightGrey.withOpacity(0.8),
            ),

            // 5. INTERACTIVE CTA ACTIONS: Re-Order & Rate Order Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    context: context,
                    icon: Icons.cached_rounded,
                    label: tr(LocaleKeys.reOrder),
                    color: context.mainColor,
                    onTap: () {},
                  ),
                  Container(
                    width: 1.2,
                    height: 14.h,
                    color: isDarkMode ? Colors.white12 : Colors.black12,
                  ),
                  _buildActionButton(
                    context: context,
                    icon: Icons.star_border_rounded,
                    label: tr(LocaleKeys.rateOrder),
                    color: Colors.amber.shade700,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.manrope(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 12.sp,
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
