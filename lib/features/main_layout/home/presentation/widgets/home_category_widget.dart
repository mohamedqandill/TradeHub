import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      width: 82.w,
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? Colors.white.withOpacity(0.05)
            : context.mainColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              imageUrl: image,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
          // SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              title,
              // textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.9)
                    : Colors.black.withOpacity(0.8),
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
