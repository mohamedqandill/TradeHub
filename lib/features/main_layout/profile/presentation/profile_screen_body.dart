import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/secure_storage/secure_storage_service.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/authentication/presentation/login/view/widgets/custom_horizontal_divider.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/features/main_layout/profile/presentation/widgets/card_info.dart';
import 'package:tradehub/features/main_layout/profile/presentation/widgets/custom_profile_row_info.dart';
import 'package:tradehub/features/main_layout/profile/presentation/widgets/profile_info_section.dart';

import '../../../../core/routes/routes.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  Map<dynamic, dynamic>? userInfo;
  @override
  void initState() {
    userInfo = getIt<HiveStorageHelper>().getMap(AppConstants.userInfo);
    super.initState();
  }

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
                name: userInfo?["fullName"] ?? "")),
        SizedBox(
          height: 15.h,
        ),
        CardInfo(
          name: userInfo?["fullName"] ?? "",
          email: userInfo?["email"] ?? "",
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
                var cartCbit = context.read<CartCubit>();

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                  child: CustomProfileRowInfo(
                    index: index,
                    title: data[index]["title"],
                    image: data[index]["image"],
                    onTapped: () {
                      if (index == 0) {
                        Navigator.pushNamed(context, Routes.yourOrders);
                      } else if (index == 2) {
                        Navigator.pushNamed(context, Routes.aboutApp);
                      } else if (index == 3) {
                        Navigator.pushNamed(context, Routes.getHelp);
                      } else if (index == 4) {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              backgroundColor: context.isDarkMode
                                  ? const Color(0xff1A1A1A)
                                  : Colors.white,
                              title: Text(
                                LocaleKeys.logOut.tr(),
                                style: context.base.theme.textTheme.titleLarge!
                                    .copyWith(
                                        color: context.mainColor,
                                        fontSize: 22.sp),
                              ),
                              content: Text(
                                LocaleKeys.areYouSureLogout.tr(),
                                style: context.base.theme.textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.grey),
                              ),
                              actions: [
                                Wrap(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          fixedSize: Size(130.w, 37.h),
                                          backgroundColor: Colors.transparent,
                                          side: BorderSide(
                                              width: 1,
                                              color: context.mainColor)),
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                      },
                                      child: Text(
                                        LocaleKeys.cancel.tr(),
                                        style: context
                                            .base.theme.textTheme.titleLarge!
                                            .copyWith(
                                                color: AppColors.grey,
                                                fontSize: 16.sp),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          fixedSize: Size(130.w, 37.h),
                                          backgroundColor: context.mainColor,
                                          side: BorderSide(
                                            width: 1,
                                            color: context.isDarkMode
                                                ? Colors.white12
                                                : Colors.black,
                                          )),
                                      onPressed: () async {
                                        Navigator.pop(dialogContext);
                                        await getIt<SecureStorageHelper>()
                                            .delete(ApiConstants.token);

                                        cartCbit.resetCart();
                                        getIt<SharedProductRepository>()
                                            .markThatFavoriteChange();
                                        if (context.mounted) {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Routes.login,
                                              (route) => false);
                                        }
                                      },
                                      child: Text(LocaleKeys.ok.tr(),
                                          style: context
                                              .base.theme.textTheme.titleLarge!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontSize: 16.sp)),
                                    )
                                  ],
                                )
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
