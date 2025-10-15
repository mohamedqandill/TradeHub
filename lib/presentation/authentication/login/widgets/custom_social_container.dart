import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/shared_widgets/svg_widget.dart';

class CustomSocialContainer extends StatelessWidget {
  const CustomSocialContainer({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(10.r)),
      child: Center(
        child: SvgWidget(
          assetName: icon,
        ),
      ),
    );
  }
}
