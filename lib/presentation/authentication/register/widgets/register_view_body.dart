import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/app_assets.dart';
import 'package:tradehub/core/base/base_inherited_widgets.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/shared_widgets/custom_text_field.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/local_keys/local_keys.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/shared_widgets/custom_large_main_button.dart';
import '../../../../core/shared_widgets/custom_rich_text.dart';
import '../../login/widgets/custom_horizontal_divider.dart';
import '../../login/widgets/custom_social_container.dart';
import '../../login/widgets/login_view_body.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    var base = BaseInheritedWidget.of(context);
    print(MediaQuery.of(context).size.height);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Image.asset(
              AppAssets.topWave,
              width: double.infinity,
              fit: BoxFit.fill,
              height: base.screenHeight < 750
                  ? 100.h
                  : base.screenHeight < 870
                      ? 150.h
                      : null,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              LocalKeys.register.tr(),
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
                    labelText: LocalKeys.firstName.tr(),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomTextField(
                    labelText: LocalKeys.lastName.tr(),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomTextField(
                    labelText: LocalKeys.emailAddress.tr(),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.email)),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomTextField(
                    labelText: LocalKeys.password.tr(),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye)),
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
                        LocalKeys.agreeTerms.tr(),
                        style: base.theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.mainColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomLargeMainButton(
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
                Navigator.pushReplacementNamed(context, Routes.login);
              },
              firstText: LocalKeys.alreadyHaveAccount.tr(),
              secondText: LocalKeys.login.tr(),
            )),
            const Spacer()
          ],
        );
      },
    );
  }
}
