import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

import '../../../../../Core/colors/app_colors.dart';
import '../../../../../core/assets/assets.gen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.address});
  final String address;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 55.h,
      title: Row(
        children: [
          Center(
            child: Image.asset(
              context.isDarkMode
                  ? Assets.icons.addressDark.path
                  : Assets.icons.address.path,
              height: 25.h,
              width: 20.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.deliverTo.tr(),
                style: context.base.theme.textTheme.bodyMedium
                    ?.copyWith(fontSize: 12.sp, color: AppColors.grey),
              ),
              Row(
                children: [
                  Text(
                    address,
                    style: context.base.theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: context.isDarkMode
                            ? AppColors.white
                            : AppColors.black),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20.sp,
                      color: context.mainColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: context.locale.languageCode == AppConstants.ar
              ? EdgeInsets.only(left: 8.w)
              : EdgeInsets.only(right: 8.w),
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? AppColors.grey.withOpacity(0.4)
                  : AppColors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(context.isDarkMode
                ? Assets.icons.notificationDark.path
                : Assets.icons.notification.path),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.h);
}
