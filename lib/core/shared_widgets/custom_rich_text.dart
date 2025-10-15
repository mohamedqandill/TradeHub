import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/base/base_inherited_widgets.dart';

import '../colors/app_colors.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {super.key,
      required this.firstText,
      required this.secondText,
      this.onTap});
  final String firstText, secondText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    var base = BaseInheritedWidget.of(context);
    return InkWell(
      onTap: onTap,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: firstText,
            style: base.theme.textTheme.labelSmall!
                .copyWith(color: AppColors.grey)),
        TextSpan(
            text: secondText,
            style: base.theme.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
                fontSize: 17.sp)),
      ])),
    );
  }
}
