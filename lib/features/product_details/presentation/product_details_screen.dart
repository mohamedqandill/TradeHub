import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/widgets/heart_button.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:tradehub/features/product_details/presentation/cubit/product_details_states.dart';
import 'package:tradehub/features/product_details/presentation/product_details_body.dart';
import 'package:tradehub/features/product_ratings/presentation/cubit/product_ratings_cubit.dart';
import 'package:tradehub/features/product_ratings/presentation/cubit/product_ratings_states.dart';

import '../../../core/shared_widgets/widgets/custom_error_widget.dart';
import '../../../core/utils/animations/loading_product_animation.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool? isFav;
  ProductDetailsCubit? prodCubit;
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ProductDetailsCubit>()..getProductDetails(id),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ProductRatingsCubit>()..getProductRatings(id),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is AddToCartErrorState) {
                showFailureSnackBar(context, messageTitle: state.message);
              }
            },
          ),
          BlocListener<ProductDetailsCubit, ProductDetailsStates>(
            listener: (context, state) {
              if (state is GetProductDetailsErrorState) {
                showFailureSnackBar(context, messageTitle: state.message);
              } else if (state is ToggleFavoriteErrorState) {
                showFailureSnackBar(context, messageTitle: state.message);
              } else if (state is ToggleFavoriteSuccessState) {
                showSuccessSnackBar(messageTitle: "Wishlist Updated");
              }
            },
          ),
          BlocListener<ProductRatingsCubit, ProductRatingsStates>(
            listener: (context, state) {
              if (state is GetProductRatingsErrorState) {
                showFailureSnackBar(context, messageTitle: state.message);
              } else if (state is AddProductRatingErrorState) {
                showFailureSnackBar(context, messageTitle: state.message);
              } else if (state is AddProductRatingSuccessState) {
                context.read<ProductDetailsCubit>().getProductDetails(id);
                showSuccessSnackBar(messageTitle: "Review Added");
              }
            },
          ),
        ],
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
          builder: (context, state) {
            final cubit = context.read<ProductDetailsCubit>();
            prodCubit = cubit;
            if (isFav == null && cubit.productDetails != null) {
              isFav = cubit.productDetails!.isFavourite;
            }

            if (state is GetProductDetailsLoadingState) {
              return Scaffold(body: loadingProductAnimation());
            }

            if (state is GetProductDetailsErrorState &&
                cubit.productDetails == null) {
              return Scaffold(
                appBar:
                    AppBar(elevation: 0, backgroundColor: Colors.transparent),
                body: CustomErrorWidget(
                  message: state.message,
                  onRetry: () => cubit.getProductDetails(id),
                ),
              );
            }

            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leadingWidth: 70.w,
                leading: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.sp,
                          color: context.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: HeartButton(
                          isTapped: isFav ?? false,
                          onTap: () {
                            setState(() {
                              isFav = !(isFav ?? false);
                            });
                            cubit.toggleFavorite(id);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: ProductDetailsBody(cubit: cubit),
              bottomNavigationBar: Container(
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? AppColors.black.withOpacity(0.9)
                        : AppColors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<ProductRatingsCubit, ProductRatingsStates>(
                        builder: (context, ratingState) {
                          final isLoading =
                              ratingState is AddProductRatingLoadingState;
                          return CustomLargeMainButton(
                            width: 120.w,
                            height: 46.h,
                            radius: 18.r,
                            isLoading: isLoading,
                            onPressed: isLoading
                                ? null
                                : () => _showAddRatingSheet(
                                      isLoading: isLoading,
                                      ratingCubit:
                                          context.read<ProductRatingsCubit>(),
                                      context,
                                      productId: id,
                                    ),
                            text: "Add rating",
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: BlocBuilder<CartCubit, CartState>(
                          builder: (context, cartState) {
                            return CustomLargeMainButton(
                              isLoading: cartState is AddToCartLoadingState,
                              onPressed: cartState is AddToCartLoadingState
                                  ? null
                                  : () =>
                                      context.read<CartCubit>().addToCart(id),
                              text: LocaleKeys.addToCart.tr(),
                              radius: 20.r,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showAddRatingSheet(BuildContext context,
      {required int productId,
      required bool isLoading,
      required ProductRatingsCubit ratingCubit}) async {
    final commentController = TextEditingController();
    int ratingValue = 5;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final bottomPadding = MediaQuery.of(ctx).viewInsets.bottom;
        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h + bottomPadding),
          decoration: BoxDecoration(
            color: ctx.isDarkMode ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: StatefulBuilder(
            builder: (ctx, setModalState) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 48.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Add your review",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: ratingValue,
                            items: List.generate(
                              5,
                              (i) => DropdownMenuItem(
                                value: i + 1,
                                child: Text("${i + 1}"),
                              ),
                            ),
                            onChanged: (v) {
                              setModalState(() {
                                ratingValue = v ?? 5;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "Rating",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: commentController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Comment",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomLargeMainButton(
                      text: "Submit",
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () async {
                              final comment = commentController.text.trim();
                              if (comment.isEmpty) return;
                              await ratingCubit.addProductRating(
                                productId: productId,
                                ratingValue: ratingValue,
                                comment: comment,
                              );

                              if (ctx.mounted) {
                                Navigator.pop(ctx);
                              }
                            },
                      radius: 16.r,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
