import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/main_color.dart';

class VendorInfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String rating;
  final String reviews;
  final String image;

  const VendorInfoCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.reviews,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Logo in a modern frame
              ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: 75.w,
                  height: 75.h,
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
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.base.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800, fontSize: 20.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subTitle,
                      style: context.base.theme.textTheme.bodyMedium?.copyWith(
                        color: context.greyOrWhite.withOpacity(0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(height: 1, color: context.greyOrWhite.withOpacity(0.1)),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                  context, Icons.star_rounded, rating, reviews, Colors.amber),
              _buildInfoItem(context, Icons.access_time_rounded, "20-30", "min",
                  Colors.blue),
              _buildInfoItem(context, Icons.delivery_dining_rounded, "Free",
                  "Delivery", Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String value,
      String label, Color iconColor) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20.sp, color: iconColor),
            SizedBox(width: 4.w),
            Text(
              value,
              style: context.base.theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: context.base.theme.textTheme.labelSmall?.copyWith(
            color: AppColors.grey,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
