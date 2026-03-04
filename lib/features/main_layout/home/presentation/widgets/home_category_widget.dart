import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget(
      {super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(3.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  context.mainColor.withOpacity(0.5),
                  context.mainColor.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(2.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    context.isDarkMode ? AppColors.lightBlack : AppColors.white,
              ),
              child: ClipOval(
                child: Image.asset(
                  image,
                  width: 54.w,
                  height: 54.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: context.isDarkMode
                  ? AppColors.white.withOpacity(0.9)
                  : AppColors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
