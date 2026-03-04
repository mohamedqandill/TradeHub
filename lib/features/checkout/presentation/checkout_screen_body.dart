import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/payment_method_section.dart';
import 'widgets/shipping_address_section.dart';

class CheckoutScreenBody extends StatelessWidget {
  const CheckoutScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShippingAddressSection(),
          SizedBox(height: 24.h),
          const PaymentMethodSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
