import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/app_assets.dart';
import 'package:tradehub/core/base/base_inherited_widgets.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/custom_text_field.dart';
import 'package:tradehub/core/shared_widgets/main_logo.dart';
import 'package:tradehub/core/shared_widgets/main_top_wave.dart';
import 'package:tradehub/features/authentication/presentation/login/bloc/login_bloc.dart';
import 'package:tradehub/main.dart';

import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../Core/shared_widgets/custom_large_main_button.dart';
import '../../../../../../Core/shared_widgets/custom_rich_text.dart';
import '../../../../../../core/functions/show_loading.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/validations/validation.dart';
import 'custom_horizontal_divider.dart';
import 'custom_social_container.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    var base = BaseInheritedWidget.of(context);
    print(MediaQuery.of(context).size.height);
    return MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current) {
              return previous.loginState != current.loginState;
            },
            listener: (context, state) {
              if (state.loginState == RequestStates.success) {
                showSuccessSnackBar(
                    title: LocaleKeys.welcome.tr(),
                    messageTitle: LocaleKeys.loggedSuccessfully.tr());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.home,
                  (route) => false,
                );
              }
              if (state.loginState == RequestStates.error) {
                showFailureSnackBar(context,
                    messageTitle: state.errorMessage.toString());
              }
            },
          ),
          BlocListener<LoginBloc, LoginState>(
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
                    messageTitle: LocaleKeys.loggedSuccessfully.tr());
              } else if (state.signWithGoogleState == RequestStates.error ||
                  state.signWithFacebookState == RequestStates.error) {
                hideDialog(context);
                showFailureSnackBar(context,
                    messageTitle: state.errorMessage.toString());
              }
            },
          ),
        ],
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            var bloc = BlocProvider.of<LoginBloc>(context);
            return SingleChildScrollView(
              child: Form(
                key: bloc.formKey,
                child: AutofillGroup(
                  child: Column(
                    children: [
                      MainTopWave(
                          height: MediaQuery.of(context).size.height < 750
                              ? 100
                              : null),
                      SizedBox(
                        height: 10.h,
                      ),
                      const MainLogo(),
                      Text(
                        LocaleKeys.login.tr(),
                        style: base.theme.textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              labelText: LocaleKeys.emailAddress.tr(),
                              suffixIcon: Icon(
                                Icons.email,
                                size: 22.sp,
                              ),
                              validator: ValidateFunctions.getInstance()
                                  .validationOfEmail,
                              controller: bloc.email,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomTextField(
                              controller: bloc.password,
                              validator: ValidateFunctions.getInstance()
                                  .validationOfPassword,
                              obscureText: !bloc.isObscureText,
                              labelText: LocaleKeys.password.tr(),
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
                                  offset: context.locale.languageCode ==
                                          AppConstants.ar
                                      ? const Offset(5, 0)
                                      : const Offset(-5, 0),
                                  child: Checkbox(
                                    visualDensity:
                                        const VisualDensity(horizontal: -4),
                                    side:
                                        const BorderSide(color: AppColors.grey),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.r)),
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
                                  LocaleKeys.rememberMe.tr(),
                                  style: base.theme.textTheme.bodyMedium!
                                      .copyWith(
                                          color: context.isDarkMode
                                              ? AppColors.white
                                              : AppColors.grey),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.forgetPassword),
                                  child: Text(
                                    LocaleKeys.forgetPassword.tr(),
                                    style: base.theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: context.mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            CustomLargeMainButton(
                              isLoading:
                                  state.loginState == RequestStates.loading,
                              onPressed: () {
                                if (bloc.formKey.currentState!.validate()) {
                                  bloc.add(const Login());
                                }
                              },
                              text: LocaleKeys.login.tr(),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Row(
                              children: [
                                const CustomHorizontalDivider(
                                  enIndent: 10,
                                ),
                                Text(
                                  LocaleKeys.orLoginWith.tr(),
                                  style: base.theme.textTheme.bodyMedium!
                                      .copyWith(
                                          color: context.isDarkMode
                                              ? AppColors.white
                                              : AppColors.grey
                                                  .withOpacity(0.8)),
                                ),
                                const CustomHorizontalDivider(
                                  indent: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Center(
                              child: SizedBox(
                                height: 48.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: List.generate(
                                    socialIcons.length,
                                    (index) {
                                      return InkWell(
                                        onTap: () {
                                          switch (index) {
                                            // case 0:
                                            //   // bloc.add(const SignWithFacebook());
                                            case 1:
                                              bloc.add(const SignWithGoogle());
                                          }
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(right: 10.sp),
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
                      //
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(
                          child: CustomRichText(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signUp);
                        },
                        firstText: LocaleKeys.dontHaveAccount.tr(),
                        secondText: LocaleKeys.create.tr(),
                      )),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

List<String> socialIcons = [
  AppAssets.facebook,
  AppAssets.google,
];
