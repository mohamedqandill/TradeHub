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
    
    return SizedBox(
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
            child: Skeletonizer(
              enabled: isLoading ?? false,
              child: HomeCategoryWidget(
                image: cubit?.categories[index].imageUrl ?? "",
                title: cubit?.categories[index].name ?? "",
              ),
            ),
          );
        },
      ),
    );
  }
}
