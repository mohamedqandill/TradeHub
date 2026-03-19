import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/custom_checkout_card.dart';

import 'widgets/payment_method_section.dart';
import 'widgets/shipping_address_section.dart';

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

  void updateAddress() {
    setState(() {
      getSavedPlaceName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShippingAddressSection(
              placeName: placeName,
              onAddressChanged: updateAddress,
            ),
            SizedBox(height: 24.h),
            const PaymentMethodSection(),
          ],
        ),
      ),
      DraggableScrollableSheet(
        snap: true,
        snapSizes: const [0.1, 0.38],
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.38,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: context.isDarkMode ? Colors.black12 : Colors.grey,
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              children: [
                // indicator
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  height: 4.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // المحتوى
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: const CustomCheckoutCard(
                      isProceedButton: false,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    ]);
  }
}
