import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';

class CategorySection extends StatelessWidget {
  final bool? isLoading;
  final HomeCubit? cubit;

  const CategorySection({super.key, this.isLoading, this.cubit});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categoriesData = [
      {
        "title": LocaleKeys.restaurants.tr(),
        "image": Assets.images.resturants.path
      },
      {"title": LocaleKeys.flowers.tr(), "image": Assets.images.flowers.path},
      {
        "title": LocaleKeys.electronics.tr(),
        "image": Assets.images.electronics.path
      },
      {
        "title": LocaleKeys.groceryMarkets.tr(),
        "image": Assets.images.grocery.path
      },
      {
        "title": LocaleKeys.furniture.tr(),
        "image": Assets.images.furniture.path
      },
      {
        "title": LocaleKeys.healthAndBeauty.tr(),
        "image": Assets.images.healthAndBeauty.path
      },
      {"title": LocaleKeys.clothes.tr(), "image": Assets.images.clothes.path},
      {
        "title": LocaleKeys.accessories.tr(),
        "image": Assets.images.accessories.path
      },
    ];
    return Skeletonizer(
      enabled: isLoading ?? false,
      child: SizedBox(
        height: 110.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: cubit?.categories.length ?? 8,
          separatorBuilder: (context, index) => SizedBox(width: 20.w),
          itemBuilder: (context, index) {
            final category = cubit?.categories[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Column(
                children: [
                  Container(
                    width: 65.w,
                    height: 65.w,
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.05)
                          : context.mainColor.withOpacity(0.05),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.mainColor.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: (category != null && index < categoriesData.length)
                          ? Image.asset(
                              categoriesData[index]["image"],
                              width: 35.w,
                              height: 35.h,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.category_outlined,
                              color: context.mainColor),
                    ),

                  ),
                  SizedBox(height: 10.h),
                  Text(
                    category?.name ?? "Category",
                    style: TextStyle(
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
