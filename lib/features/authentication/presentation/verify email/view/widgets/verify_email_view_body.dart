import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/functions/show_loading.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/custom_rich_text.dart';
import 'package:tradehub/features/authentication/data/models/verify_o_t_p_body.dart';
import 'package:tradehub/features/authentication/presentation/forget%20password/bloc/forget_password_bloc.dart';
import 'package:tradehub/features/authentication/presentation/verify%20email/bloc/verify_otp_bloc.dart';
import 'package:tradehub/main.dart';

import '../../../../../../Core/assets/app_assets.dart';
import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../core/functions/show_snakbar.dart';

class VerifyEmailViewBody extends StatelessWidget {
  const VerifyEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<VerifyOtpBloc>(context);
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
                        color: context.isDarkMode
                            ? AppColors.white
                            : AppColors.grey),
                    text: LocaleKeys.enterDigit.tr(),
                  ),
                  TextSpan(
                      text: bloc.userEmail,
                      style: context.base.theme.textTheme.bodyMedium!.copyWith(
                          color: context.isDarkMode
                              ? AppColors.white
                              : AppColors.mainColor))
                ])),
            SizedBox(
              height: 34.h,
            ),
            buildPinPut(
                bloc: bloc,
                context: context,
                isSuccess: state.verifyOTPStates == RequestStates.success,
                isError: state.verifyOTPStates == RequestStates.error),
            // SizedBox(
            //   height: 34.h,
            // ),
            // CustomLargeMainButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, Routes.newPassword);
            //   },
            //   text: LocaleKeys.verifyCode.tr(),
            // ),
            SizedBox(
              height: 48.h,
            ),
            BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
              listener: (context, state) {
                if (state.forgetPasswordState == RequestStates.loading) {
                  showLoading(context);
                }
                if (state.forgetPasswordState == RequestStates.success) {
                  hideDialog(context);
                  showSuccessSnackBar(context,
                      messageTitle: LocaleKeys.sendOTP.tr(),
                      title: LocaleKeys.otpSent.tr());
                }
              },
              child: CustomRichText(
                  onTap: () {
                    context
                        .read<ForgetPasswordBloc>()
                        .add(SendOTP(email: bloc.userEmail));
                  },
                  firstText: LocaleKeys.haventGetCode.tr(),
                  secondText: LocaleKeys.resendCode.tr()),
            )
          ],
        );
      },
    );
  }
}

Widget buildPinPut(
    {required VerifyOtpBloc bloc,
    required bool isSuccess,
    required bool isError,
    required BuildContext context}) {
  return AnimatedScale(
    scale: isSuccess ? 1.1 : 1.0,
    duration: const Duration(milliseconds: 500),
    curve: Curves.bounceOut,
    child: Pinput(
      animationCurve: Curves.bounceIn,
      keyboardType: TextInputType.number,
      length: 5,
      onCompleted: (value) {
        bloc.add(VerifyOTP(
            verifyOTPBody: VerifyOTPBody(
          code: value,
          phoneOrEmail: bloc.userEmail,
        )));
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
