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
            final isLoadingEmpty = (isLoading ?? false) &&
                state.randomProducts.isEmpty;
            final itemCount = isLoadingEmpty
                ? 3
                : state.randomProducts.length;

            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              separatorBuilder: (context, index) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                if (isLoadingEmpty) {
                  return _ProductSkeletonPlaceholder(
                    isDark: context.isDarkMode,
                  );
                }

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

class _ProductSkeletonPlaceholder extends StatelessWidget {
  final bool isDark;

  const _ProductSkeletonPlaceholder({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168.h,
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFEFF0F6),
        ),
      ),
    );
  }
}

