import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/custom_rich_text.dart';

import '../../../../../../Core/assets/app_assets.dart';
import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../Core/shared_widgets/custom_large_main_button.dart';

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
                style: context.base.theme.textTheme.bodyMedium!.copyWith(
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.grey),
                text: LocaleKeys.enterDigit.tr(),
              ),
              TextSpan(
                  text: " Moh****@gmail.com",
                  style: context.base.theme.textTheme.bodyMedium!.copyWith(
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.mainColor))
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
          text: LocaleKeys.verifyCode.tr(),
        ),
        SizedBox(
          height: 48.h,
        ),
        CustomRichText(
            firstText: LocaleKeys.haventGetCode.tr(),
            secondText: LocaleKeys.resendCode.tr())
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
