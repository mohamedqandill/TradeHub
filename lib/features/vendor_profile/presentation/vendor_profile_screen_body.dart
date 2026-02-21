import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/about_section_widget.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/product_section_widget.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/reviews_section_widget.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/vendor_top_section.dart';

class VendorProfileScreenBody extends StatefulWidget {
  const VendorProfileScreenBody({super.key});

  @override
  State<VendorProfileScreenBody> createState() =>
      _VendorProfileScreenBodyState();
}

class _VendorProfileScreenBodyState extends State<VendorProfileScreenBody>
    with SingleTickerProviderStateMixin {
  List<String> data = [
    LocaleKeys.products.tr(),
    LocaleKeys.about.tr(),
    LocaleKeys.reviews.tr()
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: data.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        // الهيدر اللي هيتسكرول لفوق
        SliverToBoxAdapter(
          child: VendorTopSection(
            title: "Modern Living",
            image: Assets.images.vendor.path,
            rating: "4.5",
            reviews: "(1,200 ${LocaleKeys.reviews.tr()})",
            subTitle: "Premium Home Furnishings",
          ),
        ),
        // TabBar ثابت فوق
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyTabBarDelegate(
            TabBar(
              unselectedLabelStyle: context.base.theme.textTheme.bodyMedium
                  ?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey),
              labelStyle: context.base.theme.textTheme.titleLarge
                  ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
              indicatorColor: context.mainColor,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
              controller: _tabController,
              tabs: data.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ),
      ],
      // المحتوى
      body: TabBarView(
        controller: _tabController,
        children: const [
          ProductSectionWidget(),
          AboutSectionWidget(),
          ReviewsSectionWidget(),
        ],
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  const _StickyTabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
