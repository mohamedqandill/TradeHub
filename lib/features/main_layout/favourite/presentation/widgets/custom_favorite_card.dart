import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/shared_widgets/widgets/heart_button.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/main.dart';

class CustomFavoriteCard extends StatefulWidget {
  const CustomFavoriteCard(
      {super.key,
      required this.image,
      required this.title,
      required this.storeName,
      required this.price,
      required this.id,
      this.isAddingToCart});
  final String image;
  final String title;
  final String storeName;
  final String price;
  final int id;
  final bool? isAddingToCart;

  @override
  State<CustomFavoriteCard> createState() => _CustomFavoriteCardState();
}

class _CustomFavoriteCardState extends State<CustomFavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.black.withOpacity(0.3)
            : AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: context.greyOrWhite.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  width: double.infinity,
                  height: 140.h,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 2.w,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                      // يبني بس لما الفافوريت تتغير
                      builder: (context, state) {
                        return HeartButton(
                          isTapped: true, // ← مش hardcoded true
                          onTap: () {
                            context
                                .read<FavouriteCubit>()
                                .toggleFavorite(widget.id);
                          },
                        );
                      },
                    )),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.base.theme.textTheme.bodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    widget.storeName,
                    style: TextStyle(
                      color: AppColors.grey.withOpacity(0.7),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // SizedBox(height: 8.h),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            "${widget.price} EGP",
                            style: TextStyle(
                              color: context.mainColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        // Material(
                        //   color: Colors.transparent,
                        //   child: InkWell(
                        //     onTap: widget.isAddingToCart ?? false
                        //         ? null
                        //         : () {
                        //             context
                        //                 .read<CartCubit>()
                        //                 .addToCart(widget.id);
                        //           },
                        //     borderRadius: BorderRadius.circular(10.r),
                        //     child: AnimatedContainer(
                        //       duration: const Duration(milliseconds: 250),
                        //       curve: Curves.easeInOut,
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: 10.w, vertical: 7.h),
                        //       decoration: BoxDecoration(
                        //         gradient: context.isDarkMode
                        //             ? AppColors.linearDarkColor
                        //             : AppColors.linearLight,
                        //         borderRadius: BorderRadius.circular(10.r),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: context.mainColor.withOpacity(0.3),
                        //             blurRadius: 8,
                        //             offset: const Offset(0, 3),
                        //           ),
                        //         ],
                        //       ),
                        //       child: widget.isAddingToCart ?? false
                        //           ? SizedBox(
                        //               width: 16.sp,
                        //               height: 16.sp,
                        //               child: const CircularProgressIndicator(
                        //                 strokeWidth: 2,
                        //                 color: Colors.white,
                        //               ),
                        //             )
                        //           : Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Icon(
                        //                   Icons.add_shopping_cart_rounded,
                        //                   size: 15.sp,
                        //                   color: Colors.white,
                        //                 ),
                        //                 SizedBox(width: 4.w),
                        //                 Text(
                        //                   "Add",
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontSize: 11.sp,
                        //                     fontWeight: FontWeight.w700,
                        //                     letterSpacing: 0.3,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
