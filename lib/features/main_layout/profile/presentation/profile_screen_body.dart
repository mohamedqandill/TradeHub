import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/secure_storage/secure_storage_service.dart';
import 'package:tradehub/features/authentication/presentation/login/view/widgets/custom_horizontal_divider.dart';
import 'package:tradehub/features/main_layout/profile/presentation/widgets/card_info.dart';
import 'package:tradehub/features/main_layout/profile/presentation/widgets/custom_profile_row_info.dart';
import 'package:tradehub/features/main_layout/profile/presentation/widgets/profile_info_section.dart';

import '../../../../core/routes/routes.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    List<Map<String, dynamic>> data = [
      {"image": Assets.icons.myOrders, "title": LocaleKeys.yourOrders.tr()},
      {"image": Assets.icons.moon, "title": LocaleKeys.darkMode.tr()},
      {"image": Assets.icons.about, "title": LocaleKeys.aboutApp.tr()},
      {"image": Assets.icons.help, "title": LocaleKeys.getHelp.tr()},
      {"image": Assets.icons.logout, "title": LocaleKeys.logOut.tr()}
    ];
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            child: ProfileInfoSection(
                onSettingTap: () {
                  Navigator.pushNamed(context, Routes.settings);
                },
                image: Assets.images.person.path,
                name: "Mohamed Qandil")),
        SizedBox(
          height: 15.h,
        ),
        CardInfo(
          name: "Mohamed Qandil",
          email: "mohamedqandil912@gmail.com",
          onEditTap: () {},
        ),
        SizedBox(
          height: 15.h,
        ),
        const CustomHorizontalDivider(
          opacity: 0.2,
          indent: 0,
          enIndent: 0,
          thickness: 10,
        ),
        SizedBox(
          height: 30.h,
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                  child: CustomProfileRowInfo(
                    index: index,
                    title: data[index]["title"],
                    image: data[index]["image"],
                    onTapped: () {
                      if (index == 2) {
                        Navigator.pushNamed(context, Routes.aboutApp);
                      } else if (index == 3) {
                        Navigator.pushNamed(context, Routes.getHelp);
                      } else if (index == 4) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                LocaleKeys.logOut.tr(),
                                style: context.base.theme.textTheme.titleLarge!
                                    .copyWith(
                                        color: context.mainColor,
                                        fontSize: 22.sp),
                              ),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: context
                                        .base.theme.textTheme.titleLarge!
                                        .copyWith(
                                            color: context.greyOrWhite,
                                            fontSize: 16.sp),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await getIt<SecureStorageHelper>()
                                        .delete(ApiConstants.token);
                                    if (context.mounted) {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          Routes.login, (route) => false);
                                    }
                                  },
                                  child: Text("OK",
                                      style: context
                                          .base.theme.textTheme.titleLarge!
                                          .copyWith(
                                              color: AppColors.red,
                                              fontSize: 16.sp)),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 28.h,
                );
              },
              itemCount: data.length),
        )
      ],
    );
  }
}
