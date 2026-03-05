import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

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
    placeName =
        getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ?? "";
  }

  void updateAddress() {
    setState(() {
      getSavedPlaceName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
