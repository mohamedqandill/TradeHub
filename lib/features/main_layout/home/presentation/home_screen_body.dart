import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_search_field.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/category_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/custom_row_headline.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/products_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/vendors_section.dart';

import '../../../../Core/colors/app_colors.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              CustomSearchField(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 24.sp,
                  color: context.isDarkMode
                      ? AppColors.white.withOpacity(0.6)
                      : AppColors.grey.withOpacity(0.6),
                ),
                hintText: LocaleKeys.searchForProducts.tr(),
              ),
              SizedBox(height: 24.h),
              Text(
                LocaleKeys.categories.tr(),
                style: context.base.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: context.isDarkMode ? AppColors.white : AppColors.black,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 16.h),
              const CategorySection(),
              SizedBox(height: 24.h),
              CustomRowHeadline(
                title: LocaleKeys.featuredVendors.tr(),
                subTitle: LocaleKeys.seeAll.tr(),
              ),
              SizedBox(height: 12.h),
              const VendorsSection(),
              SizedBox(height: 24.h),
              CustomRowHeadline(
                title: LocaleKeys.popularProducts.tr(),
                subTitle: LocaleKeys.seeAll.tr(),
              ),
              SizedBox(height: 12.h),
              const ProductsSection(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ],
    );
  }
}
