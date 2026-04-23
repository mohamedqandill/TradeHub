import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/features/category_details/presentation/widgets/vendor_card_widget.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/tab_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> categoriesData = [
    {
      "title": LocaleKeys.restaurants.tr(),
      "image": Assets.images.resturants.path
    },
    {"title": LocaleKeys.flowers.tr(), "image": Assets.images.flowers.path},
    {
      "title": LocaleKeys.electronics.tr(),
      "image": Assets.images.electronics.path
    },
    {
      "title": LocaleKeys.groceryMarkets.tr(),
      "image": Assets.images.grocery.path
    },
    {"title": LocaleKeys.furniture.tr(), "image": Assets.images.furniture.path},
    {
      "title": LocaleKeys.healthAndBeauty.tr(),
      "image": Assets.images.healthAndBeauty.path
    },
    {"title": LocaleKeys.clothes.tr(), "image": Assets.images.clothes.path},
    {
      "title": LocaleKeys.accessories.tr(),
      "image": Assets.images.accessories.path
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categoriesData.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("🔥 categories build");
    return SafeArea(
      child: Scaffold(
        appBar: MainLayoutAppBar(title: LocaleKeys.categories.tr()),
        body: Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: Column(
            children: [
              CustomTabBar(
                tabs: categoriesData
                    .map((cat) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Tab(
                            text: cat["title"],
                          ),
                        ))
                    .toList(),
                tabController: _tabController,
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: categoriesData.map((cat) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return VendorCardWidget(index: index);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
