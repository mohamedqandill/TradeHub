import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../colors/app_colors.dart';
import '../../constants/app_constants.dart';

class MainLayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainLayoutAppBar({super.key, required this.title, this.enableLeading, this.widgets});
  final String title;
  final bool? enableLeading;
  final List<Widget>? widgets;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: widgets,
      leading: enableLeading == true
          ? InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: context.locale.languageCode == AppConstants.en
                    ? EdgeInsets.only(left: 20.sp)
                    : EdgeInsets.only(right: 20.sp),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: context.mainColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color:
                        context.isDarkMode ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      title: Text(
        title,
        style: context.base.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.mainColor,
            fontSize: 22.sp),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(35.h);
}
