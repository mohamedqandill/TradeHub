import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/shared_services/app_providers.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
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
  List<Widget> screens = [
    const HomeScreen(),
    const YourOrdersScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      int selectedIndex = context.read<CartCubit>().selectedIndex;
      return Scaffold(
          bottomNavigationBar: CustomBottomNavbar(
            currentIndex: selectedIndex,
            getSelectedIndex: (index) {
              context.read<CartCubit>().changeTap(index);

              if (index == 2) {
                context.read<CartCubit>().getBasket();
              }
            },
          ),
          body: IndexedStack(
            index: selectedIndex,
            children: screens,
          ));
    });
  }
}
