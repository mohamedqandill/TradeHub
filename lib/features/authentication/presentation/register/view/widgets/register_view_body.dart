import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/base/base_inherited_widgets.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_text_field.dart';
import 'package:tradehub/core/shared_widgets/texts/custom_rich_text.dart';
import 'package:tradehub/core/validations/validation.dart';
import 'package:tradehub/features/authentication/presentation/register/bloc/register_bloc.dart';

import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../core/functions/show_loading.dart';
import '../../../../../../core/functions/show_snakbar.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/shared_widgets/widgets/main_logo.dart';
import '../../../../../../main.dart';
import '../../../login/view/widgets/custom_horizontal_divider.dart';
import '../../../login/view/widgets/custom_social_container.dart';
import '../../../login/view/widgets/login_view_body.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  @override
  Widget build(BuildContext context) {
    var base = BaseInheritedWidget.of(context);
    print(MediaQuery.of(context).size.height);
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
          listenWhen: (prev, curr) => prev.registerState != curr.registerState,
          listener: (context, state) {
            if (state.registerState == RequestStates.success) {
              Future.delayed(
                const Duration(seconds: 1),
                () => Navigator.pop(context),
              );
              showSuccessSnackBar(
                  messageTitle: tr(LocaleKeys.accountCreatedSuccessfully));
              context.read<RegisterBloc>().add(const VerifyAccount());
            } else if (state.registerState == RequestStates.error) {
              showFailureSnackBar(context,
                  messageTitle: state.errorMessage.toString());
            }
          },
        ),
        BlocListener<RegisterBloc, RegisterState>(
          listenWhen: (prev, curr) =>
              prev.signWithGoogleState != curr.signWithGoogleState ||
              prev.signWithFacebookState != curr.signWithFacebookState,
          listener: (context, state) {
            if (state.signWithGoogleState == RequestStates.loading ||
                state.signWithFacebookState == RequestStates.loading) {
              showLoading(context);
            } else if (state.signWithGoogleState == RequestStates.success ||
                state.signWithFacebookState == RequestStates.success) {
              hideDialog(context);
              showSuccessSnackBar(
                  title: LocaleKeys.welcome.tr(),
                  messageTitle: LocaleKeys.loggedSuccessfully.tr());
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainLayout,
                (route) => false,
              );
            } else if (state.signWithGoogleState == RequestStates.error ||
                state.signWithFacebookState == RequestStates.error) {
              hideDialog(context);
              showFailureSnackBar(context,
                  messageTitle: state.errorMessage.toString());
            }
          },
        ),
      ],
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        var bloc = BlocProvider.of<RegisterBloc>(context);
        return Form(
          key: bloc.formKey,
          child: AutofillGroup(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // MainTopWave(
                  //     height: context.base.screenHeight < 750
                  //         ? 0.h
                  //         : context.base.screenHeight < 866
                  //             ? 150.h
                  //             : 150.h),
                  SizedBox(
                    height: context.base.screenHeight < 750 ? 10.h : 50.h,
                  ),
                  context.base.screenHeight < 780
                      ? const SizedBox()
                      : const MainLogo(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    LocaleKeys.register.tr(),
                    style: base.theme.textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          labelText: LocaleKeys.firstName.tr(),
                          validator: (input) {
                            return ValidateFunctions.getInstance()
                                .validationOfFirstOrLastName(input);
                          },
                          controller: bloc.firstName,
                          autoFillHints: AutofillHints.name,
                        ),
                        SizedBox(
                          height: bloc.spaceHeight,
                        ),
                        CustomTextField(
                          labelText: LocaleKeys.lastName.tr(),
                          validator: (input) {
                            return ValidateFunctions.getInstance()
                                .validationOfFirstOrLastName(input,
                                    isFirstName: false);
                          },
                          controller: bloc.lastName,
                          autoFillHints: AutofillHints.familyName,
                        ),
                        SizedBox(
                          height: bloc.spaceHeight,
                        ),
                        CustomTextField(
                          labelText: LocaleKeys.phoneNumber.tr(),
                          validator: (input) {
                            return ValidateFunctions.getInstance()
                                .validationOfPhoneNumber(input);
                          },
                          controller: bloc.phoneNumber,
                          autoFillHints: AutofillHints.telephoneNumber,
                        ),
                        SizedBox(
                          height: bloc.spaceHeight,
                        ),
                        CustomTextField(
                          autoFillHints: AutofillHints.email,
                          labelText: LocaleKeys.emailAddress.tr(),
                          validator: (input) {
                            return ValidateFunctions.getInstance()
                                .validationOfEmail(input);
                          },
                          controller: bloc.email,
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.email,
                                size: 22.sp,
                              )),
                        ),
                        SizedBox(
                          height: bloc.spaceHeight,
                        ),
                        CustomTextField(
                          obscureText: !bloc.isObscureText,
                          labelText: LocaleKeys.password.tr(),
                          autoFillHints: AutofillHints.password,
                          validator: (input) {
                            return ValidateFunctions.getInstance()
                                .validationOfPassword(input);
                          },
                          controller: bloc.password,
                          suffixIcon: IconButton(
                              onPressed: () {
                                bloc.isObscureText = !bloc.isObscureText;
                                setState(() {});
                              },
                              icon: bloc.isObscureText
                                  ? Icon(
                                      Icons.visibility,
                                      size: 22.sp,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      size: 22.sp,
                                    )),
                        ),
                        Row(
                          children: [
                            Transform.translate(
                              offset:
                                  context.locale.languageCode == AppConstants.ar
                                      ? const Offset(5, 0)
                                      : const Offset(-5, 0),
                              child: Checkbox(
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                                side: const BorderSide(color: AppColors.grey),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.r)),
                                value: bloc.isRememberMe,
                                checkColor: AppColors.white,
                                activeColor: context.mainColor,
                                onChanged: (value) {
                                  setState(() {
                                    bloc.isRememberMe = value!;
                                  });
                                },
                              ),
                            ),
                            Text(
                              LocaleKeys.agreeTerms.tr(),
                              style: base.theme.textTheme.bodyMedium!.copyWith(
                                  color: context.isDarkMode
                                      ? AppColors.white
                                      : AppColors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: bloc.spaceHeight,
                        ),
                        CustomLargeMainButton(
                          isLoading:
                              state.registerState == RequestStates.loading,
                          onPressed: () {
                            if (!bloc.formKey.currentState!.validate()) {
                              bloc.waveHeight = 140.h;
                              setState(() {});
                            }
                            if (!bloc.isRememberMe) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          LocaleKeys.pleaseAgreeTerms.tr())));
                            } else if (bloc.formKey.currentState!.validate() &&
                                bloc.isRememberMe) {
                              bloc.add(const Register());
                            }
                          },
                          text: LocaleKeys.create.tr(),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Row(
                          children: [
                            const CustomHorizontalDivider(
                              enIndent: 10,
                              isExpanded: true,
                            ),
                            Text(
                              LocaleKeys.orContinueWith.tr(),
                              style: base.theme.textTheme.bodyMedium!.copyWith(
                                  color: context.isDarkMode
                                      ? AppColors.white
                                      : AppColors.grey.withOpacity(0.8)),
                            ),
                            const CustomHorizontalDivider(
                              indent: 10,
                              isExpanded: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: bloc.spaceHeight,
                        ),
                        Center(
                          child: SizedBox(
                            height: 48.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                socialIcons.length,
                                (index) {
                                  return InkWell(
                                    onTap: () {
                                      switch (index) {
                                        case 1:
                                          bloc.add(const SignWithGoogle());
                                        // case 0:
                                        //   bloc.add(const SignWithFacebook());
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.sp),
                                      child: CustomSocialContainer(
                                        icon: socialIcons[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  Center(
                      child: CustomRichText(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    firstText: LocaleKeys.alreadyHaveAccount.tr(),
                    secondText: LocaleKeys.login.tr(),
                  )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
