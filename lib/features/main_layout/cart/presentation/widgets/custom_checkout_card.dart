import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';

import '../../../../../Core/colors/app_colors.dart';
import 'custom_row_card.dart';

class CustomCheckoutCard extends StatelessWidget {
  const CustomCheckoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.black : AppColors.white,
          boxShadow: [
            BoxShadow(
                color: context.isDarkMode
                    ? AppColors.white.withOpacity(0.1)
                    : AppColors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, -4))
          ]),
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomRowText(
              title: LocaleKeys.subtotal.tr(),
              price: "140.0 EG",
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomRowText(
              title: LocaleKeys.shipping.tr(),
              price: "10.0 EG",
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomRowText(
              title: LocaleKeys.tax.tr(),
              price: "0.0",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Divider(
                color: AppColors.grey.withOpacity(0.5),
                thickness: 1,
                indent: 0,
                endIndent: 10,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.totalAmount.tr(),
                  style: context.base.theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700, color: context.mainColor),
                ),
                Text(
                  "114.0 EG",
                  style: context.base.theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700, color: context.mainColor),
                ),
              ],
            ),
            // const Spacer(),
            SizedBox(
              height: 12.h,
            ),
            CustomLargeMainButton(
              textStyle: context.base.theme.textTheme.bodyMedium!
                  .copyWith(color: AppColors.white),
              text: LocaleKeys.proceedToCheckout.tr(),
              height: 56.h,
              width: MediaQuery.sizeOf(context).width,
              onPressed: () {},
              radius: 15.r,
            )
          ],
        ),
      ),
    );
  }
}
