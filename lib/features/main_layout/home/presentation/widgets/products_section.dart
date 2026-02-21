import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

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
    return Wrap(
      spacing: 10.sp,
      runSpacing: 15.sp,
      children: productsData.map((productsData) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 36.w) / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      width: 182.w,
                      height: 160.h,
                      productsData["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    left: 5.w,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode
                            ? AppColors.black
                            : AppColors.white,
                      ),
                      width: 50.w,
                      height: 50.h,
                      child: Icon(
                        Icons.add,
                        size: 25.sp,
                        color: context.mainColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    right: 5.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        Assets.images.vendor.path,
                        fit: BoxFit.cover,
                        width: 50.w,
                        height: 50.h,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                productsData["title"],
                style: context.base.theme.textTheme.titleLarge
                    ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                productsData["priceAfterDiscount"],
                style: context.base.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                productsData["price"],
                style: context.base.theme.textTheme.titleLarge?.copyWith(
                    fontSize: 14.sp,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.grey,
                    decorationThickness: 2.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
