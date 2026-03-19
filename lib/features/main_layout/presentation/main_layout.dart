import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/features/main_layout/presentation/widgets/custom_bottomnavbar.dart';

import '../cart/presentation/cart_screen.dart';
import '../categories/presentation/categories_screen.dart';
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
    const CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);
    return Scaffold(
      bottomNavigationBar: CustomBottomNavbar(
        getSelectedIndex: (index) {
          selectedIndex = index;
          setState(() {});
        },
      ),
      body: screens[selectedIndex],
    );
  }
}
