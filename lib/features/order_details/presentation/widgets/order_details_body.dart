import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';
import 'package:tradehub/features/order_details/presentation/cubit/order_details_cubit.dart';
import 'package:tradehub/features/order_details/presentation/cubit/order_details_state.dart';
import 'package:tradehub/features/order_details/presentation/order_details_args.dart';
import 'package:tradehub/features/order_details/presentation/widgets/_buildFulfillmentAndBillingCard.dart';
import 'package:tradehub/features/order_details/presentation/widgets/bundle_offer_details_card.dart';
import 'package:tradehub/features/order_details/presentation/widgets/merchant_card.dart';
import 'package:tradehub/features/order_details/presentation/widgets/status_bar.dart';
import 'custom_order_details_card.dart';

class OrderDetailsBody extends StatelessWidget {
  final OrderDetailsArgs args;
  const OrderDetailsBody({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        if (state is GetOrderDetailsError) {
          return CustomErrorWidget(
            message: state.message,
            onRetry: () =>
                context.read<OrderDetailsCubit>().getOrderDetails(args.orderId),
          );
        }

        final bool isLoading =
            state is GetOrderDetailsLoading || state is OrderDetailsInitial;
        final orderData = state is GetOrderDetailsSuccess
            ? state.orderDetails
            : _getDummyData();

        return Skeletonizer(
          enabled: isLoading,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroHeaderCard(context, orderData),
                SizedBox(height: 16.h),
                buildItemsAndMerchantCard(context, orderData),
                SizedBox(height: 16.h),
                buildFulfillmentAndBillingCard(context, orderData),
                SizedBox(height: 16.h),
                _buildSummaryLedgerCard(context, orderData),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─────────────────── 1. HERO HEADER CARD ────────────────────────────────
  Widget _buildHeroHeaderCard(
      BuildContext context, OrderDetailsResponseDTO order) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    Color statusColor = _getStatusColor(order.orderStatus);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.04) : AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.06)
              : AppColors.lightGrey.withOpacity(0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.25)
                : Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long_rounded,
                          size: 20.sp, color: context.mainColor),
                      SizedBox(width: 8.w),
                      Text(
                        "#TRD-${order.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: textColor,
                          fontSize: 20.sp,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_rounded,
                          size: 13.sp, color: AppColors.grey),
                      SizedBox(width: 6.w),
                      Text(
                        DateFormat('dd MMM yyyy - hh:mm a')
                            .format(DateTime.parse(order.createdAt)),
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                        color: statusColor.withOpacity(0.25), width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: statusColor),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        order.orderStatus.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Divider(
                color: isDarkMode ? Colors.white12 : AppColors.lightGrey,
                thickness: 1),
          ),
          buildStatusStepper(context, order.orderStatus),
        ],
      ),
    );
  }

  // ─────────────────── 2. MERCHANT & ORDERED ITEMS CARD ───────────────────
 

 

  // ─────────────────── 4. SUMMARY RECEIPTS LEDGER CARD ────────────────────
  Widget _buildSummaryLedgerCard(
      BuildContext context, OrderDetailsResponseDTO order) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    return CustomOrderDetailsCard(
      padding: EdgeInsets.all(18.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.summarize_rounded,
                  size: 20.sp, color: context.mainColor),
              SizedBox(width: 8.w),
              Text(
                LocaleKeys.orderSummary.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    fontSize: 15.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _summaryRow(LocaleKeys.subtotal.tr(), "${order.subTotal} EGP",
              context, isDarkMode ? Colors.white70 : Colors.black87),
          SizedBox(height: 12.h),
          _summaryRow(
            LocaleKeys.shipping.tr(),
            order.deliveryFee == 0
                ? LocaleKeys.free.tr()
                : "${order.deliveryFee} EGP",
            context,
            order.deliveryFee == 0
                ? Colors.green
                : (isDarkMode ? Colors.white70 : Colors.black87),
          ),
          SizedBox(height: 16.h),
          Divider(
            color: isDarkMode
                ? Colors.white.withOpacity(0.08)
                : AppColors.lightGrey.withOpacity(0.8),
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.total.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    fontSize: 16.sp),
              ),
              Text(
                "${order.total} EGP",
                style: TextStyle(
                  color: context.mainColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
      String title, String value, BuildContext context, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp)),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: valueColor,
                fontSize: 12.sp)),
      ],
    );
  }

  // ─────────────────── TIMELINE STEPPER ───────────────────────────────────
  

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'delivered':
        return const Color(0xFF2E7D32);
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.grey;
    }
  }

  OrderDetailsResponseDTO _getDummyData() {
    return OrderDetailsResponseDTO(
      id: 0,
      subTotal: 0,
      deliveryFee: 0,
      total: 0,
      orderStatus: "Pending",
      paymentStatus: "Pending",
      address: "Loading address...",
      companyName: "Loading...",
      companyLogo: "",
      createdAt: DateTime.now().toIso8601String(),
      items: [
        OrderItemDTO(
          productId: 0,
          productName: "Product Name Placeholder",
          imageUrl: "",
          price: 0,
          quantity: 0,
        ),
      ],
      bundleItems: [],
      maskedCardNumber: "**** **** **** ****",
    );
  }
}

