import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/shared_services/app_providers.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/presentation/widgets/custom_bottomnavbar.dart';
import 'package:tradehub/features/your_orders/presentation/your_orders_screen.dart';

import '../cart/presentation/cart_screen.dart';
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
    const YourOrdersScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        selectedIndex = ModalRoute.of(context)!.settings.arguments as int;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavbar(
          currentIndex: selectedIndex,
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
