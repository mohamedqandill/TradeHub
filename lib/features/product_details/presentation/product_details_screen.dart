import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
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

import '../../../core/shared_widgets/app_bars/main_layout_app_bar.dart';
import '../../../core/shared_widgets/widgets/custom_error_widget.dart';
import '../../../core/utils/animations/loading_product_animation.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool? isFav;
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) => getIt<ProductDetailsCubit>()..getProductDetails(id),
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
        ],
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
          builder: (context, state) {
            final cubit = context.read<ProductDetailsCubit>();
            if (isFav == null && cubit.productDetails != null) {
              isFav = cubit.productDetails!.isFavourite;
            }

            if (state is GetProductDetailsLoadingState) {
              return  Scaffold(body: loadingProductAnimation());
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
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return CustomLargeMainButton(
                        isLoading: state is AddToCartLoadingState,
                        onPressed: state is AddToCartLoadingState
                            ? null
                            : () => context.read<CartCubit>().addToCart(id),
                        text: LocaleKeys.addToCart.tr(),
                        radius: 20.r,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      );
                    },
                  )),
            );
          },
        ),
      ),
    );
  }
}
