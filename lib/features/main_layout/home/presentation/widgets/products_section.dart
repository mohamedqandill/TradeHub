import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/routes/routes.dart';

import '../../../../../Core/colors/app_colors.dart';
import '../../../../../core/assets/assets.gen.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> productsData = [
      {
        "title": "Burger Sandwich",
        "image": Assets.images.image.path,
        "price": "250 EG",
        "priceAfterDiscount": "200 EG",
      },
      {
        "title": "Wireless Headphone",
        "image": Assets.images.imageT.path,
        "price": "850 EG",
        "priceAfterDiscount": "800 EG",
      },
      {
        "title": "Wireless Headphone",
        "image": Assets.images.imageT.path,
        "price": "850 EG",
        "priceAfterDiscount": "800 EG",
      },
      {
        "title": "Wireless Headphone",
        "image": Assets.images.imageT.path,
        "price": "850 EG",
        "priceAfterDiscount": "800 EG",
      },
    ];
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productsData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          // childAspectRatio: 0.8.sp,
          mainAxisExtent: 220.h),
      itemBuilder: (context, index) {
        final product = productsData[index];
        return InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.productDetails),
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? AppColors.black.withOpacity(0.3)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: context.greyOrWhite.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.r)),
                      child: Image.asset(
                        product["image"],
                        width: double.infinity,
                        height: 140.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(2.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            Assets.images.vendor.path,
                            width: 32.w,
                            height: 32.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: context.mainColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_rounded,
                              size: 16.sp,
                              color: context.isDarkMode
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              "ADD",
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? AppColors.black
                                    : AppColors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["title"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            product["priceAfterDiscount"],
                            style: TextStyle(
                              color: context.mainColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            product["price"],
                            style: TextStyle(
                              color: AppColors.grey.withOpacity(0.6),
                              fontSize: 11.sp,
                              decoration: TextDecoration.lineThrough,
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
        );
      },
    );
  }
}
