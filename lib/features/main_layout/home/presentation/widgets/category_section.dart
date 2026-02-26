import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/routes/routes.dart';

import '../../../../../core/assets/assets.gen.dart';
import '../../../../../core/localization/locale_keys.g.dart';
import 'home_category_widget.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

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
    return SizedBox(
      height: 220.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 4.w,
            crossAxisSpacing: 10.h,
            mainAxisExtent: 99.w,
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.categoryDetails),
            child: HomeCategoryWidget(
              image: categoriesData[index]["image"],
              title: categoriesData[index]["title"],
            ),
          );
        },
      ),
    );
  }
}
