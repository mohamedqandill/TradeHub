import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

class ProductReviewCard extends StatelessWidget {
  final ProductRatingDTO rating;

  const ProductReviewCard({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final name = (rating.userFullname ?? "").trim();
    final comment = (rating.comment ?? "").trim();
    final value = rating.ratingValue ?? 0;
    final createdAt = DateTime.parse(rating.createdAt!).toLocal();

    // الوقت الحالي
    final now = DateTime.now( );
    print("now: $now");
    print("createdAt: $createdAt");

    // الفرق الحقيقي
    final diff = now.difference(createdAt);
    print("diff: $diff");

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.black.withOpacity(0.3)
            : AppColors.grey.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty ? "Anonymous" : name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      diff.inDays > 0
                          ? "${diff.inDays}d ago"
                          : diff.inHours > 0
                              ? "${diff.inHours}h ago"
                              : diff.inMinutes > 0
                                  ? "${diff.inMinutes}m ago"
                                  : "just now",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.grey.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                value.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          if (comment.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              comment,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.4,
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
