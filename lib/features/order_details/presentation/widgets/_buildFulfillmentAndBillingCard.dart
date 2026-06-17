 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';
import 'package:tradehub/features/order_details/presentation/widgets/custom_order_details_card.dart';

Widget buildFulfillmentAndBillingCard(
      BuildContext context, OrderDetailsResponseDTO order) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    bool isPaid = order.paymentStatus.toLowerCase() == "paid";

    return CustomOrderDetailsCard(
      padding: EdgeInsets.all(18.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: context.mainColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.local_shipping_rounded,
                    color: context.mainColor, size: 18.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                LocaleKeys.shippingAddress.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    fontSize: 14.sp),
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.payments_rounded,
                    color: Colors.blue, size: 18.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                LocaleKeys.paymentMethod.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    fontSize: 14.sp),
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
                        Colors.purple.withOpacity(0.12),
                      ]
                    : [
                        Colors.blue.shade50.withOpacity(0.8),
                        Colors.purple.shade50.withOpacity(0.3),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 3.h),
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
                isPaid
                    ? Text(
                        order.maskedCardNumber ?? tr("•••• •••• •••• 2346"),
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                          fontSize: 13.sp,
                          fontFamily: 'monospace',
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }