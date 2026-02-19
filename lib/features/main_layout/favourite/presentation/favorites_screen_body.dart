import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/widgets/custom_favorite_card.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/shared_widgets/custom_search_field.dart';

class FavoritesScreenBody extends StatefulWidget {
  const FavoritesScreenBody({super.key});

  @override
  State<FavoritesScreenBody> createState() => _FavoritesScreenBodyState();
}

class _FavoritesScreenBodyState extends State<FavoritesScreenBody> {
  bool isHearTapped = true;

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
            prefixIcon: Image.asset(
              scale: 0.8,
              Assets.icons.search.path,
              color: context.isDarkMode
                  ? AppColors.white
                  : AppColors.grey.withOpacity(0.8),
            ),
            hintText: LocaleKeys.searchYourFavorites.tr(),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10.h,
                  ),
                ),
                SliverList.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.h,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CustomFavoriteCard(
                        image: Assets.images.tshirt.path,
                        title: "Classic T-Shirt Sport",
                        storeName: "Nike Store",
                        price: "1200");
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
