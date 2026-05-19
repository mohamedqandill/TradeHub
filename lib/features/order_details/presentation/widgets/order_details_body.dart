import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                // 1. Hero Card: Order Info & Status Timeline Tracker
                _buildHeroHeaderCard(context, orderData),
                SizedBox(height: 16.h),

                // 2. Merchant Profile & Ordered Items Card
                _buildItemsAndMerchantCard(context, orderData),
                SizedBox(height: 16.h),

                // 3. Unified Delivery Slip & Credit Card billing Details
                _buildFulfillmentAndBillingCard(context, orderData),
                SizedBox(height: 16.h),

                // 4. Financial Receipt Ledger Breakdown
                _buildSummaryLedgerCard(context, orderData),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─────────────────── 1. HERO HEADER CARD ───────────────────
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
                      Icon(
                        Icons.receipt_long_rounded,
                        size: 20.sp,
                        color: context.mainColor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "#TRD-${order.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: textColor,
                          fontSize: 22.sp,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 13.sp,
                        color: AppColors.grey,
                      ),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: statusColor.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusColor,
                      ),
                    ),
                    SizedBox(width: 6.w),
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
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Divider(
              color: isDarkMode ? Colors.white12 : AppColors.lightGrey,
              thickness: 1,
            ),
          ),
          // Timeline Stepper Progress Tracker
          _buildStatusStepper(context, order.orderStatus),
        ],
      ),
    );
  }

  // ─────────────────── 2. MERCHANT & ORDERED ITEMS CARD ───────────────────
  Widget _buildItemsAndMerchantCard(
      BuildContext context, OrderDetailsResponseDTO order) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    return CustomOrderDetailsCard(
      padding: EdgeInsets.all(18.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Merchant Sub-header
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
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: order.companyLogo,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Icon(
                      Icons.storefront_rounded,
                      color: AppColors.grey.withOpacity(0.7),
                      size: 20.sp,
                    ),
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
          Row(
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 20.sp,
                color: context.mainColor,
              ),
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
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported_outlined,
                          size: 24.sp,
                          color: AppColors.grey.withOpacity(0.5),
                        ),
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
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────── 3. FULFILLMENT & PAYMENT METHOD SLIP ───────────────────
  Widget _buildFulfillmentAndBillingCard(
      BuildContext context, OrderDetailsResponseDTO order) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    bool isPaid = order.paymentStatus.toLowerCase() == "paid";

    return CustomOrderDetailsCard(
      padding: EdgeInsets.all(18.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shipping Destination
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: context.mainColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: context.mainColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                LocaleKeys.shippingAddress.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 38.w),
            child: Text(
              order.address,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.4,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.06)
                  : AppColors.lightGrey.withOpacity(0.6),
              height: 1,
            ),
          ),
          // Card Details
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.payments_rounded,
                  color: Colors.blue,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                LocaleKeys.paymentMethod.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [
                        Colors.blue.withOpacity(0.12),
                        Colors.purple.withOpacity(0.12)
                      ]
                    : [
                        Colors.blue.shade50.withOpacity(0.8),
                        Colors.purple.shade50.withOpacity(0.3)
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isDarkMode
                    ? Colors.blue.withOpacity(0.18)
                    : Colors.blue.withOpacity(0.12),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.contactless_rounded,
                          color: isDarkMode
                              ? Colors.white54
                              : Colors.blueGrey.withOpacity(0.7),
                          size: 18.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "SECURE CHECKOUT",
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                            color: isDarkMode
                                ? Colors.white54
                                : Colors.blueGrey.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: (isPaid ? Colors.green : Colors.orange)
                            .withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        order.paymentStatus.toUpperCase(),
                        style: TextStyle(
                          color: isPaid ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w900,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  order.maskedCardNumber ?? tr("•••• •••• •••• 2346"),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                    fontSize: 13.sp,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────── 4. SUMMARY RECEIPTS LEDGER CARD ───────────────────
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
              Icon(
                Icons.summarize_rounded,
                size: 20.sp,
                color: context.mainColor,
              ),
              SizedBox(width: 8.w),
              Text(
                LocaleKeys.orderSummary.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  fontSize: 15.sp,
                ),
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
                  : (isDarkMode ? Colors.white70 : Colors.black87)),
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
                  fontSize: 16.sp,
                ),
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
        Text(
          title,
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: valueColor,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  // ─────────────────── TIMELINE STEPPER PROGRESS TRACKER ───────────────────
  Widget _buildStatusStepper(BuildContext context, String status) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    final normalizedStatus = status.toLowerCase();

    if (normalizedStatus == 'cancelled') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.cancel_rounded, color: Colors.red, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              "This order has been cancelled",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w800,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      );
    }

    int activeIndex = 0;
    if (normalizedStatus == 'confirmed') {
      activeIndex = 1;
    } else if (normalizedStatus == 'delivered') {
      activeIndex = 2;
    }

    final steps = ['Placed', 'Confirmed', 'Delivered'];

    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= activeIndex;
        final isActive = index == activeIndex;
        final stepColor = isCompleted
            ? context.mainColor
            : (isDarkMode ? Colors.white24 : Colors.black12);

        return Expanded(
          child: Row(
            children: [
              // Circle Node
              Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? stepColor : Colors.transparent,
                  border: Border.all(
                    color: stepColor,
                    width: 2.sp,
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(
                          Icons.check_rounded,
                          size: 12.sp,
                          color: Colors.white,
                        )
                      : Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white60 : Colors.black54,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 4.w),
              // Label
              Text(
                steps[index],
                style: TextStyle(
                  color: isActive
                      ? textColor
                      : (isCompleted
                          ? textColor.withOpacity(0.8)
                          : AppColors.grey),
                  fontSize: 11.sp,
                  fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                ),
              ),
              if (index < steps.length - 1)
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    height: 2.h,
                    color: index < activeIndex
                        ? context.mainColor
                        : (isDarkMode
                            ? Colors.white10
                            : Colors.black.withOpacity(0.05)),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

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
              quantity: 0)
        ],
        maskedCardNumber: "**** **** **** ****");
  }
}
