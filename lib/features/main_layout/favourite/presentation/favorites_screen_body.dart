import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/widgets/custom_favorite_card.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/shared_widgets/fields/custom_search_field.dart';

class FavoritesScreenBody extends StatefulWidget {
  const FavoritesScreenBody({super.key});

  @override
  State<FavoritesScreenBody> createState() => _FavoritesScreenBodyState();
}

class _FavoritesScreenBodyState extends State<FavoritesScreenBody> {
  bool isHearTapped = true;
  List<Map<String, dynamic>> data = [
    {
      "title": "loaded rice bowl",
      "image": Assets.images.foodA.path,
      "price": "220",
      "vendor": "Karam El-sham"
    },
    {
      "title": "loaded rice bowl",
      "price": "220",
      "image": Assets.images.foodA.path,
      "vendor": "Karam El-sham"
    },
    {
      "title": "loaded rice bowl",
      "price": "220",
      "image": Assets.images.foodA.path,
      "vendor": "Karam El-sham"
    },
    {
      "title": "loaded rice bowl",
      "price": "220",
      "image": Assets.images.foodA.path,
      "vendor": "Karam El-sham"
    }
  ];

  @override
  Widget build(BuildContext context) {
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
                      childAspectRatio: 0.68,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return CustomFavoriteCard(
                          image: data[index]["image"],
                          title: data[index]["title"],
                          storeName: data[index]["vendor"],
                          price: data[index]["price"],
                        );
                      },
                      childCount:
                          data.length, // Changed to 6 for a balanced grid
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
  }
}
