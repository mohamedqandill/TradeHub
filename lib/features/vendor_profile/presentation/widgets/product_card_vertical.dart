import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class ProductCardVertical extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  const ProductCardVertical({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Premium Image Container with Add Button
          Container(
            height: 140.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Product Image
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(1.sp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: CachedNetworkImage(
                        alignment: Alignment.center,
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
                // Add Button (Floating top-left)
                Positioned(
                  top: 0.sp,
                  left: -5.sp,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: context.mainColor, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        size: 22.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Product Details
          Padding(
            padding: EdgeInsets.only(top: 0.h, left: 4.w, right: 4.w),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                        height: 1.2,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  price,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: context.mainColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
