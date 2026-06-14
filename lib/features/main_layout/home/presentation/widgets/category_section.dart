import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/category_details/presentation/category_details_args.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_category_widget.dart';

class CategorySection extends StatelessWidget {
  final bool? isLoading;
  final HomeCubit? cubit;

  const CategorySection({super.key, this.isLoading, this.cubit});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      Assets.images.electronics.path,
      Assets.images.clothes.path,
      Assets.images.accessories.path,
      Assets.images.furniture.path,
      Assets.images.healthAndBeauty.path,
      Assets.images.markets.path,
      Assets.images.resturant.path,
    ];
    return SizedBox(
      height: 225.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cubit?.categories.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 4.w,
            crossAxisSpacing: 5.h,
            mainAxisExtent: 95.w,
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          final category = cubit?.categories[index];
          return InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.categoryDetails,
              arguments: CategoryDetailsArgs(
                categoryId: category?.id ?? 0,
                categoryName: category?.name ?? "",
              ),
            ),
            child: Skeletonizer(
              enabled: isLoading ?? false,
              child: HomeCategoryWidget(
                image: cubit?.categories[index].imageUrl??"",
                title: cubit?.categories[index].name ?? "",
              ),
            ),
          );
        },
      ),
    );
  }
}
