import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

import '../../../../Core/colors/app_colors.dart';

class CardInfo extends StatelessWidget {
  const CardInfo(
      {super.key,
      required this.name,
      required this.email,
      required this.onEditTap});
  final String name;
  final String email;
  final void Function() onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
      padding: EdgeInsets.only(bottom: 15.sp),
      width: double.infinity,
      // height: 110.h,
      decoration: BoxDecoration(
          gradient: context.isDarkMode
              ? AppColors.linearDarkColor
              : AppColors.linearLight,
          borderRadius: BorderRadius.circular(25.r)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: context.base.theme.textTheme.titleLarge!
                  .copyWith(fontSize: 21.sp, color: AppColors.white),
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              children: [
                Text(
                  email,
                  style: context.base.theme.textTheme.titleLarge!.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.lightGrey.withOpacity(0.5)),
                ),
                const Spacer(),
                InkWell(
                  onTap: onEditTap,
                  child: Text(
                    LocaleKeys.edit.tr(),
                    style: context.base.theme.textTheme.titleLarge!.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.white,
                        decorationColor: Colors.white,
                        decorationThickness: 2,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
