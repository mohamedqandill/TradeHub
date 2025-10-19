import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/Core/shared_widgets/custom_large_main_button.dart';
import 'package:tradehub/core/base/base_inherited_widgets.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/custom_text_field.dart';
import 'package:tradehub/core/validations/validation.dart';

import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../Core/localization/local_keys/local_keys.dart';
import '../../../../../../Core/shared_widgets/custom_rich_text.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/shared_widgets/main_logo.dart';
import '../../../login/view/widgets/custom_horizontal_divider.dart';
import '../../../login/view/widgets/custom_social_container.dart';
import '../../../login/view/widgets/login_view_body.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  bool isRememberMe = false;
  bool isObscureText = false;
  double spaceHeight = 16.h;
  double? waveHeight;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseInheritedWidget.of(context);
    print(MediaQuery.of(context).size.height);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // MainTopWave(
            //     height: context.base.screenHeight < 750
            //         ? .h
            //         : context.base.screenHeight < 866
            //             ? 150.h
            //             : waveHeight),
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
              LocalKeys.register.tr(),
              style: base.theme.textTheme.bodyLarge,
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: LocalKeys.firstName.tr(),
                    validator: ValidateFunctions.getInstance()
                        .validationOfFirstOrLastName,
                  ),
                  SizedBox(
                    height: spaceHeight,
                  ),
                  CustomTextField(
                    labelText: LocalKeys.lastName.tr(),
                    validator: ValidateFunctions.getInstance()
                        .validationOfFirstOrLastName,
                  ),
                  SizedBox(
                    height: spaceHeight,
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.phoneNumber.tr(),
                    validator:
                        ValidateFunctions.getInstance().validationOfPhoneNumber,
                  ),
                  SizedBox(
                    height: spaceHeight,
                  ),
                  CustomTextField(
                    labelText: LocalKeys.emailAddress.tr(),
                    validator:
                        ValidateFunctions.getInstance().validationOfEmail,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.email,
                          size: 22.sp,
                        )),
                  ),
                  SizedBox(
                    height: spaceHeight,
                  ),
                  CustomTextField(
                    labelText: LocalKeys.password.tr(),
                    validator:
                        ValidateFunctions.getInstance().validationOfPassword,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: isObscureText
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
                        offset: context.locale.languageCode == AppConstants.ar
                            ? const Offset(5, 0)
                            : const Offset(-5, 0),
                        child: Checkbox(
                          visualDensity: const VisualDensity(horizontal: -4),
                          side: const BorderSide(color: AppColors.grey),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r)),
                          value: isRememberMe,
                          checkColor: AppColors.white,
                          activeColor: context.mainColor,
                          onChanged: (value) {
                            setState(() {
                              isRememberMe = value!;
                            });
                          },
                        ),
                      ),
                      Text(
                        LocalKeys.agreeTerms.tr(),
                        style: base.theme.textTheme.bodyMedium!.copyWith(
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: spaceHeight,
                  ),
                  CustomLargeMainButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        waveHeight = 140.h;
                        setState(() {});
                      }
                    },
                    text: LocalKeys.create.tr(),
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
                        LocalKeys.orContinueWith.tr(),
                        style: base.theme.textTheme.bodyMedium!.copyWith(
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.grey.withOpacity(0.8)),
                      ),
                      const CustomHorizontalDivider(
                        indent: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: spaceHeight,
                  ),
                  Center(
                    child: SizedBox(
                      height: 48.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          socialIcons.length,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 10.sp),
                              child: CustomSocialContainer(
                                icon: socialIcons[index],
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
              firstText: LocalKeys.alreadyHaveAccount.tr(),
              secondText: LocalKeys.login.tr(),
            )),
          ],
        ),
      ),
    );
  }
}
