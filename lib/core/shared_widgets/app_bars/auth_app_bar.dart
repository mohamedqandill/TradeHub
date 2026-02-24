import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../colors/app_colors.dart';

class buildAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const buildAuthAppBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      leadingWidth: 55.w,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: context.locale.languageCode == AppConstants.en
              ? EdgeInsets.only(left: 20.sp)
              : EdgeInsets.only(right: 20.sp),
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: context.mainColor, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              color: context.isDarkMode ? AppColors.black : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(35.h);
}
