import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

import 'package:tradehub/features/main_layout/home/presentation/widgets/category_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/custom_row_headline.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/products_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/vendors_section.dart';

import 'package:tradehub/features/main_layout/home/presentation/widgets/home_header_widget.dart';

import '../../../../Core/colors/app_colors.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  late String address;
  @override
  void initState() {
    getSavedPlaceName();
    super.initState();
  }

  getSavedPlaceName() {
    address = getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ??
        "No Place Selected";
  }

  void updateAddress() {
    setState(() {
      getSavedPlaceName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        HomeHeaderWidget(
          address: address,
          onPlaceSelected: updateAddress,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.categories.tr(),
                style: context.base.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: context.isDarkMode ? AppColors.white : AppColors.black,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 16.h),
              const CategorySection(),
              SizedBox(height: 32.h),
              CustomRowHeadline(
                title: LocaleKeys.featuredVendors.tr(),
                subTitle: LocaleKeys.seeAll.tr(),
              ),
              SizedBox(height: 16.h),
              const VendorsSection(),
              SizedBox(height: 32.h),
              CustomRowHeadline(
                title: LocaleKeys.popularProducts.tr(),
                subTitle: LocaleKeys.seeAll.tr(),
              ),
              SizedBox(height: 16.h),
              const ProductsSection(),
            ],
          ),
        ),
      ],
    );
  }
}
