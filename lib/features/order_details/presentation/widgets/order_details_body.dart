import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

import 'custom_order_details_card.dart';
import 'order_status_timeline_section.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#TRD-10245",
                style: context.base.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800, // Make this highly bold
                  color: textColor,
                  fontSize: 20.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF66BB6A).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  LocaleKeys.orderDelivered.tr(),
                  style: context.base.theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF2E7D32),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            "${LocaleKeys.placedOn.tr()}30 Feb 2026",
            style: context.base.theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),
          const OrderStatusTimelineSection(),
          SizedBox(height: 24.h),
          _buildItemsSection(context, textColor),
          _buildShippingSection(context, textColor),
          _buildPaymentSection(context, textColor),
          _buildOrderSummarySection(context, textColor),
          SizedBox(height: 24.h),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildItemsSection(BuildContext context, Color textColor) {
    return CustomOrderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${LocaleKeys.items.tr()} (1)",
            style: context.base.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  Assets.images.foodA.path,
                  fit: BoxFit.cover,
                  width: 80.w,
                  height: 80.h,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Loaded Rice Bowl",
                      style: context.base.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "${LocaleKeys.qty.tr()}: 1",
                      style: context.base.theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "180.00 EGP",
                      style: context.base.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: context.mainColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildShippingSection(BuildContext context, Color textColor) {
    return CustomOrderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgWidget(
                assetName: Assets.icons.address,
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 8.w),
              Text(
                LocaleKeys.shippingAddress.tr(),
                style: context.base.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mohamed Qandil",
                  style: context.base.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "10th Of Ramadan City",
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context, Color textColor) {
    return CustomOrderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.credit_card_outlined, color: AppColors.grey),
              SizedBox(width: 8.w),
              Text(
                LocaleKeys.paymentMethod.tr(),
                style: context.base.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Text(
              "Vodafone Cash ending in 2345",
              style: context.base.theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderSummarySection(BuildContext context, Color textColor) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.subtotal.tr(),
                style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey, fontWeight: FontWeight.w500),
              ),
              Text("180.00 EGP",
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  )),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.shipping.tr(),
                style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey, fontWeight: FontWeight.w500),
              ),
              Text(LocaleKeys.free.tr(),
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF2E7D32),
                      fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.tax.tr(),
                style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey, fontWeight: FontWeight.w500),
              ),
              Text("18.00 EGP",
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  )),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.grey.withOpacity(0.2)),
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
                "198.00 EGP",
                style: context.base.theme.textTheme.titleLarge?.copyWith(
                  color: context.mainColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
