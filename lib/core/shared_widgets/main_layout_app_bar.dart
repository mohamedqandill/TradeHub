import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../constants/app_constants.dart';

class MainLayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainLayoutAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: context.base.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.mainColor,
            fontSize: 22.sp),
      ),
      actions: [
        Padding(
          padding: context.locale.languageCode == AppConstants.ar
              ? EdgeInsets.only(left: 20.w)
              : EdgeInsets.only(right: 20.w),
          child: Image.asset(
            Assets.icons.search.path,
            width: 20.w,
            height: 20.w,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(35.h);
}
