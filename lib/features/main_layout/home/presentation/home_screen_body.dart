import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/custom_search_field.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/category_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/custom_row_headline.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/products_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/vendors_section.dart';

import '../../../../Core/colors/app_colors.dart';
import '../../../../core/assets/assets.gen.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchField(
                  prefixIcon: Image.asset(
                    scale: 0.8,
                    Assets.icons.search.path,
                    color: context.isDarkMode
                        ? AppColors.white
                        : AppColors.grey.withOpacity(0.8),
                  ),
                  hintText: LocaleKeys.searchForProducts.tr()),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Text(
                  LocaleKeys.categories.tr(),
                  style: context.base.theme.textTheme.titleLarge
                      ?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              const CategorySection(),
              SizedBox(
                height: 15.h,
              ),
              CustomRowHeadline(
                  title: LocaleKeys.featuredVendors.tr(),
                  subTitle: LocaleKeys.seeAll.tr()),
              SizedBox(
                height: 8.h,
              ),
              const VendorsSection(),
              SizedBox(
                height: 8.h,
              ),
              CustomRowHeadline(
                  title: LocaleKeys.popularProducts.tr(),
                  subTitle: LocaleKeys.seeAll.tr()),
              SizedBox(
                height: 8.h,
              ),
              const Center(child: ProductsSection())
            ],
          ),
        ),
      ],
    );
  }
}
