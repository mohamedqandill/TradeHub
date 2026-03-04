import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';

class CustomRowHeadline extends StatelessWidget {
  const CustomRowHeadline(
      {super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Text(
            title,
            style: context.base.theme.textTheme.titleLarge
                ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          subTitle,
          style: context.base.theme.textTheme.titleLarge
              ?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
