import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';

import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../data/models/verify_otp/verify_o_t_p_body.dart';
import '../../bloc/verify_otp_bloc.dart';

Widget buildPinPut(
    {required VerifyOtpBloc bloc,
    required bool isSuccess,
    required bool isError,
    required Function(String code) getCode,
    required BuildContext context}) {
  return AnimatedScale(
    scale: isSuccess ? 1.1 : 1.0,
    duration: const Duration(milliseconds: 500),
    curve: Curves.bounceOut,
    child: Pinput(
      animationCurve: Curves.bounceIn,
      keyboardType: TextInputType.number,
      length: 5,
      onCompleted: (code) {
        bloc.add(VerifyOTP(
            verifyOTPBody: VerifyOTPBody(
          code: code,
          phoneOrEmail: bloc.userEmail,
        )));
        getCode(code);
      },
      forceErrorState: isError,
      errorText: LocaleKeys.otp_invalid.tr(),
      errorPinTheme: PinTheme(
        textStyle: context.base.theme.textTheme.bodyMedium!
            .copyWith(color: Colors.black),
        width: 50.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 2, color: AppColors.red)),
        height: 50.h,
      ),
      closeKeyboardWhenCompleted: true,
      defaultPinTheme: PinTheme(
        textStyle: context.base.theme.textTheme.bodyMedium!
            .copyWith(color: isSuccess ? AppColors.mainColor : Colors.black),
        width: 50.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                width: 2,
                color: isSuccess ? AppColors.mainColor : AppColors.grey)),
        height: 50.h,
      ),
      separatorBuilder: (index) {
        return SizedBox(
          width: 15.w,
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
            border: Border.all(width: 2, color: AppColors.mainColor)),
        height: 50.h,
      ),
    ),
  );
}

class UserEmailAndCode {
  final String email;
  final String code;
  UserEmailAndCode({required this.email, required this.code});
}
