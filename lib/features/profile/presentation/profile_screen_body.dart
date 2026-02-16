import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/authentication/presentation/login/view/widgets/custom_horizontal_divider.dart';
import 'package:tradehub/features/profile/presentation/widgets/card_info.dart';
import 'package:tradehub/features/profile/presentation/widgets/custom_profile_row_info.dart';
import 'package:tradehub/features/profile/presentation/widgets/profile_info_section.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {"image": Assets.icons.orders.path, "title": LocaleKeys.yourOrders.tr()},
      {"image": Assets.icons.moon.path, "title": LocaleKeys.darkMode.tr()},
      {"image": Assets.icons.about.path, "title": LocaleKeys.aboutApp.tr()},
      {"image": Assets.icons.help.path, "title": LocaleKeys.getHelp.tr()},
      {"image": Assets.icons.logout.path, "title": LocaleKeys.logOut.tr()}
    ];
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            child: ProfileInfoSection(
                onSettingTap: () {},
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
                    onTapped: () {},
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
