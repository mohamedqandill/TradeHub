import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/validations/validation.dart';
import 'package:tradehub/main.dart';

import '../../../../../../Core/assets/app_assets.dart';
import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/shared_widgets/fields/custom_text_field.dart';
import '../../bloc/new_password_bloc.dart';

class NewPasswordViewBody extends StatefulWidget {
  const NewPasswordViewBody({super.key});

  @override
  State<NewPasswordViewBody> createState() => _NewPasswordViewBodyState();
}

class _NewPasswordViewBodyState extends State<NewPasswordViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPasswordBloc, NewPasswordState>(
      listener: (context, state) {
        if (state.newPasswordState == RequestStates.success) {
          showSuccessSnackBar(
              messageTitle: LocaleKeys.passwordChangeSuccess.tr());
          Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            ),
          );
        }
        if (state.newPasswordState == RequestStates.error) {
          showFailureSnackBar(context,
              messageTitle: state.errorMessage.toString());
        }
      },
      builder: (context, state) {
        var bloc = context.read<NewPasswordBloc>();
        return Form(
          key: bloc.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 48.h,
              ),
              Center(child: Image.asset(AppAssets.strongPassword)),
              SizedBox(
                height: 27.h,
              ),
              Text(
                textAlign: TextAlign.center,
                LocaleKeys.passwordMustBeDiff.tr(),
                style: context.base.theme.textTheme.bodyMedium!.copyWith(
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.grey),
              ),
              SizedBox(
                height: 34.h,
              ),
              Column(
                children: [
                  CustomTextField(
                    controller: bloc.newPassword,
                    validator: (string) {
                      return ValidateFunctions.getInstance()
                          .validationOfPassword(string);
                    },
                    obscureText: !bloc.isVisible,
                    labelText: LocaleKeys.newPassword.tr(),
                    suffixIcon: InkWell(
                        onTap: () {
                          bloc.isVisible = !bloc.isVisible;
                          setState(() {});
                        },
                        child: bloc.isVisible
                            ? Icon(
                                Icons.visibility,
                                size: 22.sp,
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: 22.sp,
                              )),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  CustomLargeMainButton(
                    isLoading: state.newPasswordState == RequestStates.loading,
                    onPressed: () {
                      if (bloc.formKey.currentState!.validate()) {
                        bloc.add(const NewPassword());
                      }
                    },
                    text: LocaleKeys.save.tr(),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
