import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget(
      {super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              image,
              width: 58.w,
              height: 58.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: context.base.theme.textTheme.labelSmall
                  ?.copyWith(fontSize: 14.sp),
            ),
          )
        ],
      ),
    );
  }
}
