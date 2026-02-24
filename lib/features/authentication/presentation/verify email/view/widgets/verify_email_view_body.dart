import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/functions/show_loading.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/texts/custom_rich_text.dart';
import 'package:tradehub/features/authentication/presentation/forget%20password/bloc/forget_password_bloc.dart';
import 'package:tradehub/features/authentication/presentation/verify%20email/bloc/verify_otp_bloc.dart';
import 'package:tradehub/features/authentication/presentation/verify%20email/view/widgets/pin_put.dart';
import 'package:tradehub/main.dart';

import '../../../../../../Core/assets/app_assets.dart';
import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../core/functions/show_snakbar.dart';
import '../../../../../../core/routes/routes.dart';

class VerifyEmailViewBody extends StatelessWidget {
  const VerifyEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) {
        var bloc = context.read<VerifyOtpBloc>();
        if (state.verifyOTPStates == RequestStates.success) {
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.pushReplacementNamed(context, Routes.newPassword,
                  arguments:
                      UserEmailAndCode(email: bloc.userEmail, code: bloc.code));
            },
          );
        }
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
                getCode: (code) {
                  bloc.code = code;
                },
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
                  showSuccessSnackBar(
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
