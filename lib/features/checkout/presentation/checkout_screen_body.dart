import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/checkout/presentation/payment_webview_screen.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/custom_checkout_card.dart';

class CheckoutScreenBody extends StatefulWidget {
  const CheckoutScreenBody({super.key});

  @override
  State<CheckoutScreenBody> createState() => _CheckoutScreenBodyState();
}

class _CheckoutScreenBodyState extends State<CheckoutScreenBody> {
  String placeName = "";

  @override
  void initState() {
    getSavedPlaceName();
    super.initState();
  }

  getSavedPlaceName() {
    placeName = getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ??
        "No Place Selected";
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final cartItems = cubit.items;

    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, "Shipping Address"),
              SizedBox(height: 12.h),
              _buildAddressCard(context),
              SizedBox(height: 24.h),
              _buildSectionHeader(context, "Order Summary"),
              SizedBox(height: 16.h),
              if (cartItems != null)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartItems.items.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = cartItems.items[index];
                    return _buildCheckoutItem(context, item);
                  },
                ),
              SizedBox(height: 24.h),
              _buildPaymentBrief(context),
              SizedBox(height: 120.h), // Space for bottom card
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              return CustomCheckoutCard(
                subTotal: cartItems?.subTotal ?? 0,
                isProceedButton: false,
                buttonText: "PAY NOW",
                buttonIcon: Icons.security_rounded,
                isLoading: state is CheckoutLoading,
                onTap: () {
                  if (cubit.checkoutResponse?.paymentUrl != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentWebViewScreen(
                          url: cubit.checkoutResponse!.paymentUrl!,
                          cubit: cubit,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w800,
        color: context.isDarkMode ? Colors.white : Colors.black,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: context.mainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.location_on_rounded, color: context.mainColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Address",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  placeName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutItem(BuildContext context, dynamic item) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.white10 : AppColors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: item.pictureUrl,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined, size: 20.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.price} EGP",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "x${item.quantity}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.mainColor,
                        fontWeight: FontWeight.w800,
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
  }

  Widget _buildPaymentBrief(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.mainColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.mainColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card_rounded, color: context.mainColor, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "You will be redirected to pay securely via Visa/Mastercard.",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
