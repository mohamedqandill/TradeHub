import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/features/checkout/presentation/widgets/order_summary_section.dart';
import 'package:tradehub/features/checkout/presentation/widgets/pay_now_section.dart';

class CustomCheckoutCard extends StatelessWidget {
  const CustomCheckoutCard(
      {super.key, this.isProceedButton, this.subTotal = 0, this.isLoading});
  final bool? isProceedButton;
  final int subTotal;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : const Color(0xFFF3F6F8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: OrderSummarySection(
                  subTotal: subTotal,
                 
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: isProceedButton == null
                    ? CustomLargeMainButton(
                        showArrow: true,
                        textStyle: context.base.theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.white, fontSize: 16.sp),
                        text: LocaleKeys.proceedToCheckout.tr(),
                        height: 56.h,
                        width: MediaQuery.sizeOf(context).width,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.checkout);
                        },
                        radius: 15.r,
                      )
                    : const PayNowSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
