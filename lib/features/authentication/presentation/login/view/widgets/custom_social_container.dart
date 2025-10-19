import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

import '../../../../../../Core/colors/app_colors.dart';
import '../../../../../../Core/shared_widgets/svg_widget.dart';

class CustomSocialContainer extends StatelessWidget {
  const CustomSocialContainer({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.grey : Colors.transparent,
          border: Border.all(
              width: 2,
              color: context.isDarkMode
                  ? AppColors.mainDarkColor
                  : AppColors.lightGrey),
          borderRadius: BorderRadius.circular(10.r)),
      child: Center(
        child: SvgWidget(
          assetName: icon,
          height: 22.h,
        ),
      ),
    );
  }
}
