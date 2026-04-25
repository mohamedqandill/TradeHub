import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/widgets/heart_button.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';

import '../../../../../Core/colors/app_colors.dart';

class ProductsSection extends StatelessWidget {
  final bool? isLoading;
  final HomeCubit? cubit;

  const ProductsSection({super.key, this.isLoading, this.cubit});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading ?? false,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            showSuccessSnackBar(messageTitle: "Added To Cart");
          }

          if (state is AddToCartErrorState) {
            showFailureSnackBar(context, messageTitle: "Failed");
          }
        },
        builder: (context, state) {
          var cartCubit = context.read<CartCubit>();
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cubit?.randomProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 14.h,
                mainAxisExtent: 300.h),
            itemBuilder: (context, index) {
              final product = cubit!.randomProducts[index];
              return _ProductCard(
                product: product,
                cartCubit: cartCubit,
                isDark: context.isDarkMode,
                mainColor: context.mainColor,
              );
            },
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final dynamic product;
  final CartCubit cartCubit;
  final bool isDark;
  final Color mainColor;

  const _ProductCard({
    required this.product,
    required this.cartCubit,
    required this.isDark,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final int rating = product.averageRating ?? 0;
    final bool isAddingToCart = cartCubit.loadingProductId == product.id;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.productDetails,
        arguments: product.id,
      ),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.06) : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color:
                isDark ? Colors.white.withOpacity(0.08) : AppColors.lightGrey,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
            if (!isDark)
              BoxShadow(
                color: mainColor.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Image Section ───
            _buildImageSection(context),

            // ─── Info Section ───
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    _buildCategoryBadge(context),
                    SizedBox(height: 6.h),

                    // Title
                    Text(
                      product.name ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? AppColors.white : AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        height: 1.3,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Rating Row
                    _buildRatingRow(rating),

                    const Spacer(),

                    // Price + Add to Cart
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: _buildBottomRow(context, isAddingToCart),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          child: SizedBox(
            height: 130.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: (product.imageUrl?.isNotEmpty == true)
                      ? product.imageUrl!
                      : "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
                  placeholder: (context, url) => Container(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : AppColors.lightGrey,
                    child: Center(
                      child: SizedBox(
                        width: 22.sp,
                        height: 22.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : AppColors.lightGrey,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 28.sp,
                      color: AppColors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                // Subtle gradient overlay at bottom for depth
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          (isDark ? Colors.black : Colors.white)
                              .withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Favourite Button
        Positioned(
          top: 8.h,
          right: 6.w,
          child: Container(
            padding: EdgeInsets.all(2.sp),
            decoration: BoxDecoration(
              color: (isDark ? Colors.black : Colors.white).withOpacity(0.85),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                return HeartButton(
                  width: 24.w,
                  height: 24.h,
                  isTapped: context
                      .watch<FavouriteCubit>()
                      .favoritesIds
                      .contains(product.id),
                  onTap: () {
                    context
                        .read<FavouriteCubit>()
                        .toggleFavorite(product.id ?? 0);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(BuildContext context) {
    final categoryText = (product.categoryName?.isNotEmpty == true)
        ? product.categoryName!
        : "General";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: mainColor.withOpacity(isDark ? 0.18 : 0.08),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        categoryText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: mainColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildRatingRow(int rating) {
    return Row(
      children: [
        ...List.generate(5, (i) {
          return Icon(
            i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 14.sp,
            color: i < rating
                ? const Color(0xffFFC107)
                : AppColors.grey.withOpacity(0.35),
          );
        }),
        SizedBox(width: 4.w),
        Text(
          "($rating)",
          style: TextStyle(
            color: AppColors.grey.withOpacity(0.7),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomRow(BuildContext context, bool isAddingToCart) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Price
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${product.price ?? 0} EGP",
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 15.sp,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),

        // Add to Cart Button
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isAddingToCart
                ? null
                : () {
                    cartCubit.addToCart(product.id ?? 0);
                  },
            borderRadius: BorderRadius.circular(10.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                gradient:
                    isDark ? AppColors.linearDarkColor : AppColors.linearLight,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: mainColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: isAddingToCart
                  ? SizedBox(
                      width: 16.sp,
                      height: 16.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_shopping_cart_rounded,
                          size: 15.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
