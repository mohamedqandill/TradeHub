import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/shared_widgets/svg_widget.dart';
import 'package:tradehub/features/onBoarding/view_model/theme_view_model.dart';

import '../../../../../core/localization/locale_keys.g.dart';

class CustomProfileRowInfo extends StatefulWidget {
  const CustomProfileRowInfo(
      {super.key,
      this.image,
      required this.title,
      required this.onTapped,
      required this.index,
      this.titleBeforeIcon});

  final String? image;
  final String? titleBeforeIcon;
  final String title;
  final void Function() onTapped;
  final int index;

  @override
  State<CustomProfileRowInfo> createState() => _CustomProfileRowInfoState();
}

class _CustomProfileRowInfoState extends State<CustomProfileRowInfo> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeViewModel>();
    final isDark = themeProvider.mode == ThemeMode.dark;
    return InkWell(
      onTap: widget.onTapped,
      child: Row(
        children: [
          widget.image != null
              ? SvgWidget(
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.cover,
                  color: context.isDarkMode
                      ? widget.index == 4
                          ? AppColors.red
                          : AppColors.white
                      : null,
                  assetName: widget.image!,
                )
              : const SizedBox(),
          SizedBox(
            width: 15.w,
          ),
          Text(
            widget.title,
            style: context.base.theme.textTheme.titleLarge!.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: widget.index == 4 ? AppColors.red : null),
          ),
          const Spacer(),
          widget.index == 1
              ? Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
                  width: 60.w,
                  height: 30.h,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(isDark
                                    ? Assets.images.darkToggle.path
                                    : Assets.images.lightToggle.path))),
                      ),
                      SizedBox.expand(
                        child: Transform.scale(
                          scaleX: 1.25.w,
                          scaleY: 1.1.h,
                          child: Switch(
                            trackOutlineColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0,
                            activeThumbImage:
                                AssetImage(Assets.images.moon.path),
                            inactiveThumbImage:
                                AssetImage(Assets.images.sun.path),
                            value: isDark,
                            onChanged: (val) {
                              if (val) {
                                themeProvider.changeTheme(ThemeMode.dark);
                              } else {
                                themeProvider.changeTheme(ThemeMode.light);
                              }
                            },
                            activeColor: Colors.transparent,
                            inactiveThumbColor: Colors.transparent,
                            activeTrackColor: Colors.transparent,
                            inactiveTrackColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    widget.titleBeforeIcon != null
                        ? Text(
                            LocaleKeys.edit.tr(),
                            style: context.base.theme.textTheme.titleLarge!
                                .copyWith(
                                    fontSize: 15.sp,
                                    color: AppColors.white,
                                    decorationColor: Colors.white,
                                    decorationThickness: 2,
                                    decoration: TextDecoration.underline),
                          )
                        : const SizedBox(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 25.sp,
                      color: context.isDarkMode ? AppColors.white : null,
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
