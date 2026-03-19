import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/custom_checkout_card.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/tab_bar.dart';

import 'widgets/custom_cart_card.dart';

class CartScreenBody extends StatefulWidget {
  const CartScreenBody({super.key});

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> stores = [
    "Town Team",
    "Karam El-Sham",
  ];

  final List<Map<String, dynamic>> data = [
    {
      "image": Assets.images.foodA.path,
      "title": "loaded rice bowl",
      "size": "M",
      "price": "180"
    },
    {
      "image": Assets.images.foodB.path,
      "title": "loaded rice bowl",
      "size": "M",
      "price": "180"
    },
    {
      "image": Assets.images.tshirt.path,
      "title": "Classic T-Shirt Sport",
      "size": "XL",
      "color": "WHITE",
      "price": "1200"
    },
    {
      "image": Assets.images.jeans.path,
      "title": "Denim Jeans",
      "size": "XL",
      "color": "BLUE",
      "price": "1000"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: stores.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // المحتوى الأساسي
        Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: Column(
            children: [
              CustomTabBar(
                tabs: stores
                    .map((store) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Tab(text: store),
                        ))
                    .toList(),
                tabController: _tabController,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: stores.map((store) {
                    return CustomScrollView(
                      slivers: [
                        SliverList.separated(
                          itemBuilder: (context, index) {
                            return CustomCartCard(
                              title: data[index]["title"],
                              image: data[index]["image"],
                              price: data[index]["price"],
                              color: data[index]["color"],
                              size: data[index]["size"],
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(height: 20.h),
                          itemCount: data.length,
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        DraggableScrollableSheet(
          snap: true,
          snapSizes: const [0.1, 0.38],
          initialChildSize: 0.1,
          minChildSize: 0.1,
          maxChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.isDarkMode ? Colors.black12 : Colors.grey,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    height: 4.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: const CustomCheckoutCard(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
