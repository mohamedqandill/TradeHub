import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/widgets/heart_button.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:tradehub/features/product_details/presentation/cubit/product_details_states.dart';
import 'package:tradehub/features/product_details/presentation/product_details_body.dart';
import 'package:tradehub/features/product_details/presentation/widgets/success_dialog.dart';
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
  bool isChangeOccur = false;
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
              if (state is AddToCartSuccessState) {
                successDialog(context);
              } else if (state is AddToCartErrorState) {
                showFailureSnackBar(context, messageTitle: state.message);
              }
            },
          ),
          BlocListener<ProductDetailsCubit, ProductDetailsStates>(
            listener: (context, state) {
              if (state is ToggleFavoriteErrorState) {
                showFailureSnackBar(context, messageTitle: state.message);
              } else if (state is ToggleFavoriteSuccessState) {
                showSuccessSnackBar(messageTitle: "Wishlist Updated");
              }
            },
          ),
          BlocListener<ProductRatingsCubit, ProductRatingsStates>(
            listener: (context, state) {
              if (state is AddProductRatingErrorState) {
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
                            isChangeOccur = true;
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
                          BlocBuilder<ProductRatingsCubit,
                              ProductRatingsStates>(
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
                                          ratingCubit: context
                                              .read<ProductRatingsCubit>(),
                                          context,
                                          productId: id,
                                        ),
                                text: "Add rating",
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 100.ms)
                                  .slideX(begin: -0.2);
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
                                          context.read<CartCubit>().addToCart(
                                                id,
                                                selectedOptionValueIds: prodCubit
                                                    ?.selectedOptionValueIds,
                                              ),
                                  text: LocaleKeys.addToCart.tr(),
                                  radius: 20.r,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 200.ms)
                                    .slideX(begin: 0.2);
                              },
                            ),
                          ),
                        ],
                      ))
                  .animate()
                  .slideY(
                      begin: 1,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutCubic),
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
    final formKey = GlobalKey<FormState>();
    int ratingValue = 5;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final bottomPadding = MediaQuery.of(ctx).viewInsets.bottom;
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            final sheetColor =
                ctx.isDarkMode ? AppColors.black : AppColors.white;
            final textColor =
                ctx.isDarkMode ? AppColors.white : AppColors.black;
            final borderColor =
                ctx.isDarkMode ? Colors.white12 : Colors.black12;

            Widget buildStars() {
              return Row(
                children: List.generate(5, (i) {
                  final isFilled = (i + 1) <= ratingValue;
                  return InkWell(
                    onTap: () => setModalState(() => ratingValue = i + 1),
                    borderRadius: BorderRadius.circular(99.r),
                    child: Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: Icon(
                        isFilled
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: isFilled
                            ? const Color(0xffFFC107)
                            : AppColors.grey.withOpacity(0.6),
                        size: 28.sp,
                      ),
                    ),
                  );
                }),
              );
            }

            return AnimatedPadding(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: SafeArea(
                top: false,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 16.h),
                    decoration: BoxDecoration(
                      color: sheetColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28.r)),
                      border: Border.all(color: borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 30,
                          offset: const Offset(0, -10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 48.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: AppColors.grey.withOpacity(0.28),
                                  borderRadius: BorderRadius.circular(99.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Rate this product",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w900,
                                      color: textColor,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: AppColors.grey.withOpacity(0.75),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Your feedback helps others choose better.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                height: 1.4,
                                color: AppColors.grey.withOpacity(0.85),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Container(
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                color: ctx.isDarkMode
                                    ? Colors.white.withOpacity(0.06)
                                    : AppColors.grey.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(18.r),
                                border: Border.all(color: borderColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Rating",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w800,
                                          color: textColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFFC107)
                                              .withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(99.r),
                                        ),
                                        child: Text(
                                          "$ratingValue/5",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xffFFC107),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  buildStars(),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextFormField(
                              controller: commentController,
                              minLines: 3,
                              maxLines: 3,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                fontSize: 13.sp,
                                height: 1.45,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                              decoration: InputDecoration(
                                labelText: "Comment *",
                                hintText: "Tell us what you liked (or not).",
                                alignLabelWithHint: true,
                                filled: true,
                                fillColor: ctx.isDarkMode
                                    ? Colors.white.withOpacity(0.06)
                                    : AppColors.grey.withOpacity(0.06),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.r),
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.r),
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.r),
                                  borderSide: BorderSide(
                                    color: ctx.isDarkMode
                                        ? Colors.white24
                                        : Colors.black26,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                              validator: (v) {
                                final text = (v ?? "").trim();
                                if (text.isEmpty) return "Comment is required";
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () => Navigator.pop(ctx),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14.h),
                                      side: BorderSide(color: borderColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: CustomLargeMainButton(
                                    text: "Submit",
                                    isLoading: isLoading,
                                    onPressed: isLoading
                                        ? null
                                        : () async {
                                            if (!(formKey.currentState
                                                    ?.validate() ??
                                                false)) {
                                              return;
                                            }

                                            final comment =
                                                commentController.text.trim();
                                            await ratingCubit.addProductRating(
                                              productId: productId,
                                              ratingValue: ratingValue,
                                              comment: comment,
                                            );

                                            if (ctx.mounted) {
                                              Navigator.pop(ctx);
                                              isChangeOccur = true;
                                            }
                                          },
                                    radius: 16.r,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
