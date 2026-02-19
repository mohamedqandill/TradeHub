import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../../../../core/assets/assets.gen.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection(
      {super.key,
      required this.image,
      required this.name,
      required this.onSettingTap});
  final String image;
  final String name;
  final void Function() onSettingTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            image,
            width: 60.w,
            height: 60.h,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: context.base.theme.textTheme.titleLarge!
                  .copyWith(fontSize: 21.sp),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Image.asset(
                  Assets.icons.eg.path,
                  width: 20.w,
                  height: 20.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  "Egypt",
                  style: context.base.theme.textTheme.bodySmall!
                      .copyWith(fontSize: 13.sp, color: context.greyOrWhite),
                )
              ],
            )
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: onSettingTap,
          child: Image.asset(
            Assets.icons.setting.path,
            width: 26.w,
            height: 26.h,
            fit: BoxFit.cover,
            color: context.isDarkMode ? AppColors.white : Colors.black,
          ),
        )
      ],
    );
  }
}
//
