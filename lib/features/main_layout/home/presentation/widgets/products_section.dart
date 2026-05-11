import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/product_card.dart';

class ProductsSection extends StatelessWidget {
  final bool? isLoading;

  const ProductsSection({
    super.key,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading ?? false,
      child: MultiBlocListener(
          listeners: [
            BlocListener<CartCubit, CartState>(listener: (context, state) {
              if (state is AddToCartSuccessState) {
                showSuccessSnackBar(messageTitle: "Added To Cart");
              }

              if (state is AddToCartErrorState) {
                showFailureSnackBar(context, messageTitle: "Failed");
              }
            }),
          ],
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            var cartCubit = context.watch<CartCubit>();
            return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.randomProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  mainAxisExtent: 300.h),
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.randomProducts[index],
                  cartCubit: cartCubit,
                  isDark: context.isDarkMode,
                  mainColor: context.mainColor,
                );
              },
            );
          })),
    );
  }
}

