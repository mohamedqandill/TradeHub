import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/widgets/custom_favorite_card.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/widgets/empty_favorite_screen_body.dart';
import 'package:tradehub/main.dart';

import '../../../../core/shared_widgets/fields/custom_search_field.dart';

class FavoritesScreenBody extends StatefulWidget {
  const FavoritesScreenBody({super.key});

  @override
  State<FavoritesScreenBody> createState() => _FavoritesScreenBodyState();
}

class _FavoritesScreenBodyState extends State<FavoritesScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
      var cubit = context.read<FavouriteCubit>();
      if (state.getFavoritesState == RequestStates.loading) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
            color: context.mainColor,
          ),
        );
      } else if (state.getFavoritesState == RequestStates.success &&
          cubit.favorites.isEmpty) {
        return const EmptyFavoriteScreenBody();
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            CustomSearchField(
              prefixIcon: Icon(
                Icons.search_sharp,
                size: 24.sp,
                color: context.isDarkMode
                    ? AppColors.white
                    : AppColors.grey.withOpacity(0.8),
              ),
              hintText: LocaleKeys.searchYourFavorites.tr(),
            ),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16.h,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.62,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var product = cubit.favorites[index];
                          return Skeletonizer(
                            enabled: state.getFavoritesState ==
                                RequestStates.loading,
                            child: CustomFavoriteCard(
                              id: product.id,
                              image:
                                  "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png", // Adjust based on your asset logic
                              title: product.name,
                              storeName: product.companyName,
                              price: product.price.toString(),
                            ),
                          );
                        },
                        childCount: cubit.favorites.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
