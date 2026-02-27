import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';

import 'package:tradehub/core/routes/routes.dart';

class VendorCardWidget extends StatelessWidget {
  final int index;

  const VendorCardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.vendorProfile);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color:
                      context.isDarkMode ? AppColors.lightBlack : Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: context.isDarkMode
                        ? Colors.white12
                        : Colors.grey.shade200,
                    width: 1,
                  ),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.karamelshaam.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Karam El-Sham",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: context.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Food, Deserts ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: Colors.amber, size: 18.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "4.4",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "(100+)",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                        if (index % 3 == 0) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.stars_rounded,
                                    color: Colors.orange, size: 12.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  "Exceptional",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            color: context.isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                            size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "41 mins",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.circle,
                            color: context.isDarkMode
                                ? Colors.white24
                                : Colors.grey.shade300,
                            size: 4.sp),
                        SizedBox(width: 8.w),
                        Icon(Icons.motorcycle_outlined,
                            color: context.isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                            size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "EGP 7.50",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (index != 5)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(
              color: context.isDarkMode ? Colors.white12 : Colors.grey.shade200,
              thickness: 2,
              height: 1,
            ),
          )
        else
          SizedBox(height: 16.h),
      ],
    );
  }
}
