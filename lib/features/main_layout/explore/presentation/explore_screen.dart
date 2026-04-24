import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/main_layout/explore/presentation/widgets/explore_search_bar.dart';
import 'package:tradehub/features/main_layout/explore/presentation/widgets/explore_filter_chips.dart';
import 'package:tradehub/features/main_layout/explore/presentation/widgets/trending_vendor_card.dart';
import 'package:tradehub/features/main_layout/explore/presentation/widgets/explore_offer_banner.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: LocaleKeys.explore.tr(),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Advanced Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 5.h),
              child: const ExploreSearchBar(),
            ),
          ),

          // 2. Filter Chips (Rating, Price, Distance)
          SliverToBoxAdapter(
            child: const ExploreFilterChips(),
          ),

          // 3. Offers Section (Premium Banners)
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, "Exclusive Offers", () {}),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (context, index) => SizedBox(width: 15.w),
                itemBuilder: (context, index) => const ExploreOfferBanner(),
              ),
            ),
          ),

          // 4. Trending Vendors Section
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, "Trending Vendors", () {}),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: TrendingVendorCard(index: index),
                ),
                childCount: 5,
              ),
            ),
          ),

          // Bottom Spacing
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, VoidCallback onSeeAll) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.base.theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              "See All",
              style: TextStyle(
                color: context.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
