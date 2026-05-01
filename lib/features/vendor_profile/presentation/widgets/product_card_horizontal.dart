import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class ProductCardHorizontal extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String image;
  final String rating;
  final String reviewSnippet;

  const ProductCardHorizontal({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.reviewSnippet,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode ? AppColors.white : AppColors.black;
    final subTextColor = (context.isDarkMode ? AppColors.whiteGrey : AppColors.grey)
        .withOpacity(0.8);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.lightBlack.withOpacity(0.55)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: context.isDarkMode ? Colors.white12 : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container with Plus button
              Stack(
                children: [
                  Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) => Icon(
                            Icons.store,
                            size: 40.sp,
                            color: context.mainColor,
                          ),
                          placeholder: (context, url) => Icon(
                            Icons.store,
                            size: 40.sp,
                            color: context.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.black.withOpacity(0.9)
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.isDarkMode
                              ? Colors.white12
                              : Colors.black12,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 20.sp,
                        color: context.isDarkMode ? AppColors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: TextStyle(
                        color: subTextColor,
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      price,
                      style: TextStyle(
                        color: context.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Footer: Rating and Review
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: context.isDarkMode ? Colors.white12 : Colors.black12,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 14.sp, color: const Color(0xffFFC107)),
                    SizedBox(width: 4.w),
                    Text(
                      rating,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "\"$reviewSnippet\"",
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 11.sp,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
