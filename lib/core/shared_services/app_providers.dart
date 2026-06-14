import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/main_layout/profile/presentation/cubit/profile_cubit.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';

abstract class AppBlocProviders {
  static List<BlocProvider> providers({BuildContext? context}) {
    return [
      BlocProvider(
        create: (context) => getIt<CartCubit>(),
      ),
      BlocProvider(
        create: (context) => getIt<FavouriteCubit>(),
      ),
      BlocProvider(
        create: (context) => getIt<ProfileCubit>(),
      ),
      BlocProvider(
        create: (context) => getIt<CheckoutCubit>(),
      ),
      BlocProvider(
        create: (context) => getIt<OrdersCubit>(),
      ),
    ];
  }
}
