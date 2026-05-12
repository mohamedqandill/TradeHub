import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/order_details/presentation/order_details_args.dart';
import 'package:tradehub/features/your_orders/data/models/order_response_d_t_o.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart'
    as cart;

class OrderCardWidget extends StatelessWidget {
  final OrderResponseDTO order;
  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.orderDetails,
          arguments: OrderDetailsArgs(
            orderId: order.id ?? 0,
            items: order.items
                    ?.map((e) => cart.Items(
                          total: e.price! * e.quantity!,
                          id: 0, // Not needed for details view usually
                          productId: e.productId ?? 0,
                          productName: e.productName ?? "",
                          pictureUrl: e.imageUrl ?? "",
                          price: e.price ?? 0,
                          quantity: e.quantity ?? 0,
                        ))
                    .toList() ??
                [],
            address: order.address ?? "",
            status: order.orderStatus ?? "",
            subTotal: order.subTotal ?? 0,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.lightBlack : AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isDarkMode
                            ? AppColors.grey.withOpacity(0.3)
                            : AppColors.grey.withOpacity(0.1),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImage(
                        imageUrl: order.companyLogo ?? "",
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.business_outlined),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Order Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.companyName ?? "",
                          style: context.base.theme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: context.mainColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          order.orderStatus ?? "",
                          style: GoogleFonts.manrope(
                            color: _getStatusColor(order.orderStatus),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _formatDate(order.createdAt),
                          style:
                              context.base.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "${tr(LocaleKeys.orderId)} ${order.id}",
                          style:
                              context.base.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: isDarkMode
                  ? AppColors.grey.withOpacity(0.3)
                  : AppColors.grey.withOpacity(0.1),
            ),
            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    icon: Icons.cached_outlined,
                    label: tr(LocaleKeys.reOrder),
                    onTap: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.sentiment_satisfied_alt_outlined,
                    label: tr(LocaleKeys.rateOrder),
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

  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange, size: 18.sp),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.manrope(
              color: Colors.deepOrange,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Delivered":
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
      return DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }
}
