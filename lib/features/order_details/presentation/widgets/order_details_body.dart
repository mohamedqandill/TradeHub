import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';
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
                _buildHeader(context, orderData),
                SizedBox(height: 24.h),
                _buildCompanySection(context, orderData),
                SizedBox(height: 24.h),
                _buildItemsSection(context, orderData),
                SizedBox(height: 24.h),
                _buildShippingSection(context, orderData),
                SizedBox(height: 24.h),
                _buildPaymentSection(context, orderData),
                SizedBox(height: 24.h),
                _buildOrderSummarySection(context, orderData),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, OrderDetailsResponseDTO order) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "#TRD-${order.id}",
              style: context.base.theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: textColor,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "${LocaleKeys.placedOn.tr()}\n ${DateFormat('dd MMM yyyy').format(DateTime.parse(order.createdAt))}",
              style: context.base.theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: _getStatusColor(order.orderStatus).withOpacity(0.15),
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(
                color: _getStatusColor(order.orderStatus).withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getStatusIcon(order.orderStatus),
                  size: 16.sp, color: _getStatusColor(order.orderStatus)),
              SizedBox(width: 6.w),
              Text(
                order.orderStatus,
                style: context.base.theme.textTheme.bodySmall?.copyWith(
                  color: _getStatusColor(order.orderStatus),
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanySection(
      BuildContext context, OrderDetailsResponseDTO order) {
    return CustomOrderDetailsCard(
      padding: EdgeInsets.all(16.sp),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.grey.withOpacity(0.2)),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: order.companyLogo,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.business),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.companyName,
                  style: context.base.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.black,
                  ),
                ),
                Text(
                  "SELLER",
                  style: context.base.theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(
      BuildContext context, OrderDetailsResponseDTO order) {
    Color textColor = context.isDarkMode ? AppColors.white : AppColors.black;
    return CustomOrderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${LocaleKeys.items.tr()} (${order.items.length})",
            style: context.base.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 16.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Divider(color: AppColors.grey.withOpacity(0.1)),
            ),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.contain,
                      width: 70.w,
                      height: 70.h,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: context.base.theme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            fontSize: 15.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${LocaleKeys.qty.tr()}: ${item.quantity}",
                              style: context.base.theme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${item.price} EGP",
                              style: context.base.theme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: context.mainColor,
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

  Widget _buildShippingSection(
      BuildContext context, OrderDetailsResponseDTO order) {
    Color textColor = context.isDarkMode ? AppColors.white : AppColors.black;
    return CustomOrderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: context.mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.location_on_rounded,
                    color: context.mainColor, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                LocaleKeys.shippingAddress.tr(),
                style: context.base.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 40.w),
            child: Text(
              order.address,
              style: context.base.theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
                height: 1.4,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentSection(
      BuildContext context, OrderDetailsResponseDTO order) {
    Color textColor = context.isDarkMode ? AppColors.white : AppColors.black;
    return CustomOrderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.credit_card_rounded,
                    color: Colors.blue, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                LocaleKeys.paymentMethod.tr(),
                style: context.base.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.maskedCardNumber ?? "**** **** **** **** 2346",
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  order.paymentStatus,
                  style: context.base.theme.textTheme.bodySmall?.copyWith(
                    color: order.paymentStatus == "Paid"
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderSummarySection(
      BuildContext context, OrderDetailsResponseDTO order) {
    Color textColor = context.isDarkMode ? AppColors.white : AppColors.black;
    return CustomOrderDetailsCard(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.orderSummary.tr(),
            style: context.base.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          SizedBox(height: 16.h),
          _summaryRow(LocaleKeys.subtotal.tr(), "${order.subTotal} EGP",
              context, textColor),
          SizedBox(height: 12.h),
          _summaryRow(
              LocaleKeys.shipping.tr(),
              order.deliveryFee == 0
                  ? LocaleKeys.free.tr()
                  : "${order.deliveryFee} EGP",
              context,
              order.deliveryFee == 0 ? Colors.green : textColor),
          SizedBox(height: 16.h),
          Divider(color: AppColors.grey.withOpacity(0.15), thickness: 1),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.total.tr(),
                style: context.base.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    fontSize: 18.sp),
              ),
              Text(
                "${order.total} EGP",
                style: context.base.theme.textTheme.titleLarge?.copyWith(
                  color: context.mainColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
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
          style: context.base.theme.textTheme.bodyMedium
              ?.copyWith(color: AppColors.grey, fontWeight: FontWeight.w500),
        ),
        Text(value,
            style: context.base.theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: valueColor,
            )),
      ],
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

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle_rounded;
      case 'delivered':
        return Icons.local_shipping_rounded;
      case 'pending':
        return Icons.access_time_filled_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.info_rounded;
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
