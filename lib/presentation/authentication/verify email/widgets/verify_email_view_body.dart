import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/custom_rich_text.dart';

import '../../../../core/assets/app_assets.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/local_keys/local_keys.dart';
import '../../../../core/shared_widgets/custom_large_main_button.dart';

class VerifyEmailViewBody extends StatelessWidget {
  const VerifyEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48.h,
        ),
        Center(child: Image.asset(AppAssets.passwordProtection)),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                style: context.base.theme.textTheme.bodyMedium!
                    .copyWith(color: AppColors.grey),
                text: LocalKeys.enterDigit.tr(),
              ),
              TextSpan(
                  text: " Moh****@gmail.com",
                  style: context.base.theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.mainColor))
            ])),
        SizedBox(
          height: 34.h,
        ),
        buildPinPut(),
        SizedBox(
          height: 34.h,
        ),
        CustomLargeMainButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.newPassword);
          },
          text: LocalKeys.verifyCode.tr(),
        ),
        SizedBox(
          height: 48.h,
        ),
        CustomRichText(
            firstText: LocalKeys.haventGetCode.tr(),
            secondText: LocalKeys.resendCode.tr())
      ],
    );
  }
}

Widget buildPinPut() {
  return Pinput(
    closeKeyboardWhenCompleted: true,
    defaultPinTheme: PinTheme(
      width: 50.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 2, color: AppColors.grey)),
      height: 50.h,
    ),
    separatorBuilder: (index) {
      return SizedBox(
        width: 20.w,
      );
    },
    disabledPinTheme: PinTheme(
      width: 50.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 2, color: AppColors.white)),
      height: 50.h,
    ),
    enabled: true,
    focusedPinTheme: PinTheme(
      width: 50.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 2, color: AppColors.black)),
      height: 50.h,
    ),
  );
}
