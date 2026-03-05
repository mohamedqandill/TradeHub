import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';

import '../../../../core/localization/locale_keys.g.dart';

class PayNowSection extends StatelessWidget {
  const PayNowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomLargeMainButton(
          suffixIcon: Row(
            children: [
              SizedBox(width: 8.w),
              Icon(
                Icons.lock_outline,
                color: AppColors.white,
                size: 20.sp,
              ),
            ],
          ),
          textStyle: context.base.theme.textTheme.bodyMedium!
              .copyWith(color: AppColors.white),
          text: LocaleKeys.payNow.tr(),
          height: 56.h,
          width: MediaQuery.sizeOf(context).width,
          onPressed: () {},
          radius: 15.r,
        ),
        SizedBox(height: 16.h),
        Text(
          LocaleKeys.secureCheckout.tr().toUpperCase(),
          style: context.base.theme.textTheme.labelSmall?.copyWith(
            color: AppColors.grey.withOpacity(0.6),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
