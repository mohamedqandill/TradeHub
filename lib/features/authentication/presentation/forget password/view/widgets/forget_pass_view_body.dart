import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_text_field.dart';
import 'package:tradehub/core/validations/validation.dart';
import 'package:tradehub/features/authentication/presentation/forget%20password/bloc/forget_password_bloc.dart';
import 'package:tradehub/main.dart';

import '../../../../../../Core/assets/app_assets.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/routes/routes.dart';

class ForgetPassViewBody extends StatelessWidget {
  const ForgetPassViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state.forgetPasswordState == RequestStates.success) {
          showSuccessSnackBar(
              messageTitle: LocaleKeys.sendOTP.tr(),
              title: LocaleKeys.otpSent.tr());
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.pushNamed(context, Routes.verifyEmail,
                  arguments:
                      BlocProvider.of<ForgetPasswordBloc>(context).email.text);
            },
          );
        }
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<ForgetPasswordBloc>(context);

        return Form(
          key: bloc.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 48.h,
              ),
              Center(child: Image.asset(AppAssets.dataSecurity)),
              SizedBox(
                height: 27.h,
              ),
              Text(
                textAlign: TextAlign.center,
                LocaleKeys.enterEmail.tr(),
                style: context.base.theme.textTheme.bodyMedium!.copyWith(
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.grey),
              ),
              SizedBox(
                height: 34.h,
              ),
              CustomTextField(
                controller: bloc.email,
                validator: (input) {
                  return ValidateFunctions.getInstance()
                      .validationOfEmail(input);
                },
                labelText: LocaleKeys.emailAddress.tr(),
                suffixIcon: const Icon(Icons.email),
              ),
              SizedBox(
                height: 34.h,
              ),
              CustomLargeMainButton(
                isLoading: state.forgetPasswordState == RequestStates.loading,
                onPressed: () {
                  if (bloc.formKey.currentState!.validate()) {
                    bloc.add(const SendOTP());
                  }
                },
                text: LocaleKeys.send.tr(),
              )
            ],
          ),
        );
      },
    );
  }
}
