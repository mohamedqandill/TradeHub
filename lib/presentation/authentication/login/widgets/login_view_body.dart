import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/app_assets.dart';
import 'package:tradehub/core/base/base_inherited_widgets.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/custom_text_field.dart';
import 'package:tradehub/core/shared_widgets/svg_widget.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/local_keys/local_keys.dart';
import '../../../../core/shared_widgets/custom_large_main_button.dart';
import '../../../../core/shared_widgets/custom_rich_text.dart';
import 'custom_horizontal_divider.dart';
import 'custom_social_container.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isRememberMe = false;
  bool isObscureText = false;
  @override
  Widget build(BuildContext context) {
    var base = BaseInheritedWidget.of(context);
    print(MediaQuery.of(context).size.height);
    return Column(
      children: [
        Image.asset(
          AppAssets.topWave,
          width: double.infinity,
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height < 800 ? 100 : null,
        ),
        SizedBox(
          height: 10.h,
        ),
        const SvgWidget(assetName: AppAssets.mainLogo),
        Text(
          LocalKeys.login.tr(),
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
                labelText: LocalKeys.emailAddress.tr(),
                suffixIcon: const Icon(Icons.email),
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomTextField(
                labelText: LocalKeys.password.tr(),
                suffixIcon: IconButton(
                    onPressed: () {
                      isObscureText = !isObscureText;
                      setState(() {});
                    },
                    icon: isObscureText
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
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
                      activeColor: AppColors.mainColor,
                      onChanged: (value) {
                        setState(() {
                          isRememberMe = value!;
                        });
                      },
                    ),
                  ),
                  Text(
                    LocalKeys.rememberMe.tr(),
                    style: base.theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.grey),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.forgetPassword),
                    child: Text(
                      LocalKeys.forgetPassword.tr(),
                      style: base.theme.textTheme.bodyMedium!
                          .copyWith(color: AppColors.mainColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomLargeMainButton(
                text: LocalKeys.login.tr(),
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
                    LocalKeys.orLoginWith.tr(),
                    style: base.theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.grey.withOpacity(0.8)),
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
        const Spacer(),
        Center(
            child: CustomRichText(
          onTap: () {
            Navigator.pushNamed(context, Routes.signUp);
          },
          firstText: LocalKeys.dontHaveAccount.tr(),
          secondText: LocalKeys.create.tr(),
        )),
        const Spacer()
      ],
    );
  }
}

List<String> socialIcons = [
  AppAssets.facebook,
  AppAssets.google,
  AppAssets.phone
];
