import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

import '../../../../../core/assets/assets.gen.dart';
import 'profile_picture_widget.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({
    super.key,
    required this.name,
    required this.onSettingTap,
    this.profileImageUrl,
  });
  final String name;
  final void Function() onSettingTap;
  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePictureWidget(
          networkImageUrl: profileImageUrl,
          size: 80,
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
          child: SvgWidget(
            assetName: Assets.icons.settings,
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
