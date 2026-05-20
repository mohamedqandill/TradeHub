import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_text_field.dart';
import 'package:tradehub/core/validations/validation.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'cubit/change_password_cubit.dart';
import 'cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: Scaffold(
        appBar: MainLayoutAppBar(
          title: LocaleKeys.changePassword.tr(),
          enableLeading: true,
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              showSuccessSnackBar(messageTitle: "Password changed successfully!");
              Navigator.pop(context);
            } else if (state is ChangePasswordError) {
              showFailureSnackBar(context, messageTitle: state.error.message);
            }
          },
          builder: (context, state) {
            final cubit = context.read<ChangePasswordCubit>();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Icon(
                      Icons.lock_reset_rounded,
                      size: 100.sp,
                      color: context.isDarkMode ? AppColors.white.withOpacity(0.8) : AppColors.lightBlack.withOpacity(0.6),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Update Your Password",
                      style: context.base.theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Please enter your current password and your desired new password.",
                      textAlign: TextAlign.center,
                      style: context.base.theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(height: 36.h),
                    CustomTextField(
                      controller: _currentPasswordController,
                      obscureText: !_isCurrentPasswordVisible,
                      labelText: "Current Password",
                      hintText: "Enter current password",
                      validator: (value) {
                        return ValidateFunctions.getInstance().validationOfPassword(value);
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isCurrentPasswordVisible
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: _newPasswordController,
                      obscureText: !_isNewPasswordVisible,
                      labelText: "New Password",
                      hintText: "Enter new password",
                      validator: (value) {
                        return ValidateFunctions.getInstance().validationOfPassword(value);
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _isNewPasswordVisible = !_isNewPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isNewPasswordVisible
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomLargeMainButton(
                      isLoading: state is ChangePasswordLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.changePassword(
                            currentPassword: _currentPasswordController.text,
                            newPassword: _newPasswordController.text,
                          );
                        }
                      },
                      text: "Change Password",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
