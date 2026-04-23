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
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_category_widget.dart';

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
        height: 220.h,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cubit?.categories.length ?? 0,
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
                title: cubit?.categories[index].name ?? "",
              ),
            );
          },
        ),
      ),
    );
  }
}
