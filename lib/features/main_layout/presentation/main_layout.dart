import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/favourite_screen.dart';
import 'package:tradehub/features/main_layout/presentation/widgets/custom_bottomnavbar.dart';

import '../cart/presentation/cart_screen.dart';
import '../explore/presentation/explore_screen.dart';
import '../home/presentation/home_screen.dart';
import '../profile/presentation/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    // EasyLocalization.of(context);
    return Scaffold(
        bottomNavigationBar: CustomBottomNavbar(
          getSelectedIndex: (index) {
            setState(() {
              selectedIndex = index;
            });
            if (index == 2) {
              context.read<CartCubit>().getBasket();
            }
          },
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: screens,
        ));
  }
}
