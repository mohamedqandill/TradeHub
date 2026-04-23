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
import '../../../../../core/assets/assets.gen.dart';

class ProductsSection extends StatelessWidget {
  final bool? isLoading;
  final HomeCubit? cubit;

  const ProductsSection({super.key, this.isLoading, this.cubit});

  @override
  Widget build(BuildContext context) {
    // late int currentIndex;
    // List<Map<String, dynamic>> productsData = [
    //   {
    //     "title": "loaded rice bowl",
    //     "image": Assets.images.foodA.path,
    //     "price": "220 EGP",
    //     "priceAfterDiscount": "200 EGP",
    //   },
    //   {
    //     "title": "loaded rice bowl",
    //     "image": Assets.images.foodB.path,
    //     "price": "220 EGP",
    //     "priceAfterDiscount": "200 EGP",
    //   },
    //   {
    //     "title": "Burger Sandwich",
    //     "image": Assets.images.image.path,
    //     "price": "220 EGP",
    //     "priceAfterDiscount": "190 EGP",
    //   },
    //   {
    //     "title": "loaded rice bowl",
    //     "image": Assets.images.foodA.path,
    //     "price": "220 EGP",
    //     "priceAfterDiscount": "200 EGP",
    //   },
    // ];
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
          var homeCubit = context.read<HomeCubit>();
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeCubit.randomProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.8.sp,
                mainAxisExtent: 240.h),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.pushNamed(context, Routes.productDetails,
                    arguments: cubit?.randomProducts[index].id),
                borderRadius: BorderRadius.circular(24.r),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image & Badge Stack
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24.r)),
                            child: CachedNetworkImage(
                              height: 130.h,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 22.sp,
                              ),
                            ),
                          ),
                          // Vendor Mini Logo
                          // Positioned(
                          //   top: 10.h,
                          //   right: 0.w,
                          //   child: Container(
                          //     padding: EdgeInsets.all(3.sp),
                          //     decoration: const BoxDecoration(
                          //       color: Colors.white,
                          //       shape: BoxShape.circle,
                          //       boxShadow: [
                          //         BoxShadow(
                          //             color: Colors.black12,
                          //             blurRadius: 4,
                          //             spreadRadius: 1)
                          //       ],
                          //     ),
                          //     child: BlocBuilder<FavouriteCubit,FavouriteState>(
                          //       builder: (context, state) {
                          //         return ClipOval(
                          //           child: HeartButton(
                          //         width: 25.w,
                          //         height: 25.h,
                          //         isTapped: context.watch<FavouriteCubit>().favoritesIds.contains(cubit?.randomProducts[index].id),
                          //         onTap: () {

                          //           context.read<FavouriteCubit>().toggleFavorite(cubit!.randomProducts[index].id??0);
                          //         },
                          //       ));
                          //       },

                          //     ),
                          //   ),
                          // ),
                          // Add Button
                          Positioned(
                            bottom: 8.h,
                            right: 8.w,
                            child: InkWell(
                              onTap: () {
                                cartCubit.addToCart(
                                    cubit?.randomProducts[index].id ?? 0);
                              },
                              child: Container(
                                padding: EdgeInsets.all(6.sp),
                                decoration: BoxDecoration(
                                  color: context.mainColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.mainColor.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: cartCubit.loadingProductId ==
                                        cubit?.randomProducts[index].id
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 4,
                                        ),
                                      )
                                    : Icon(
                                        Icons.add_rounded,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Product Info
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit?.randomProducts[index].name ?? "",
                              maxLines: 2,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14.sp,
                                letterSpacing: -0.2,
                              ),
                            ),
                            // SizedBox(height: 4.h),
                            Text(
                              // cubit?.randomProducts[index].companyName ??
                              "Online Store",
                              maxLines: 1,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "${cubit?.randomProducts[index].price.toString() ?? ""} EGP",
                                  style: TextStyle(
                                    color: context.mainColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                // SizedBox(width: 6.w),
                                // Text(
                                //   product["price"],
                                //   style: TextStyle(
                                //     color: Colors.grey.shade400,
                                //     fontSize: 11.sp,
                                //     decoration: TextDecoration.lineThrough,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
