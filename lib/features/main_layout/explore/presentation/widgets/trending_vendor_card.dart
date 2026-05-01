import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';

class TrendingVendorCard extends StatelessWidget {
  final int index;
  const TrendingVendorCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.lightBlack.withOpacity(0.55)
            : Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: context.isDarkMode ? Colors.white12 : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withOpacity(0.25)
                : Colors.grey.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Vendor Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(
              Assets.images.karamelshaam.path,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15.w),
          // Vendor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Karam El-Sham",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.sp,
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.black,
                          ),
                    ),
                    Icon(Icons.verified_rounded,
                        color: Colors.blue, size: 18.sp),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "Surian & Egyptian Food",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _buildInfoTag(
                        context, Icons.star_rounded, "4.5", Colors.amber),
                    SizedBox(width: 10.w),
                    _buildInfoTag(context, Icons.location_on_rounded, "1.2 km",
                        Colors.redAccent),
                    SizedBox(width: 10.w),
                    _buildInfoTag(context, Icons.access_time_rounded, "25 min",
                        Colors.blueAccent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(
      BuildContext context, IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: color),
        SizedBox(width: 2.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: context.isDarkMode ? AppColors.whiteGrey : AppColors.black,
          ),
        ),
      ],
    );
  }
}
