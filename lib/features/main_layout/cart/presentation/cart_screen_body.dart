import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: Column(
        children: [
          CustomTabBar(
              tabs: stores
                  .map((store) => Tab(
                        text: store,
                      ))
                  .toList(),
              tabController: _tabController),
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
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.h,
                        );
                      },
                      itemCount: data.length,
                    )
                  ],
                );
              }).toList(),
            ),
          ),
          const CustomCheckoutCard()
        ],
      ),
    );
  }
}
