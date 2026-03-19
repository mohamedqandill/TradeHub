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
        "title": "loaded rice bowl",
        "image": Assets.images.foodA.path,
        "price": "220 EGP",
        "priceAfterDiscount": "200 EGP",
      },
      {
        "title": "loaded rice bowl",
        "image": Assets.images.foodB.path,
        "price": "220 EGP",
        "priceAfterDiscount": "200 EGP",
      },
      {
        "title": "Burger Sandwich",
        "image": Assets.images.image.path,
        "price": "220 EGP",
        "priceAfterDiscount": "190 EGP",
      },
      {
        "title": "loaded rice bowl",
        "image": Assets.images.foodA.path,
        "price": "220 EGP",
        "priceAfterDiscount": "200 EGP",
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
          borderRadius: BorderRadius.circular(24.r),
          child: Container(
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image & Badge Stack
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24.r)),
                      child: Image.asset(
                        product["image"],
                        width: double.infinity,
                        height: 125.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Vendor Mini Logo
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.all(3.sp),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 1)
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            Assets.images.karamelshaam.path,
                            width: 28.w,
                            height: 28.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Add Button
                    Positioned(
                      bottom: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(6.sp),
                        decoration: BoxDecoration(
                          color: context.mainColor,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: context.mainColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // Product Info
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            product["priceAfterDiscount"],
                            style: TextStyle(
                              color: context.mainColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            product["price"],
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 11.sp,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w600,
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
