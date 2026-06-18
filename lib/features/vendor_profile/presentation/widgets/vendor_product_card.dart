import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/shared_widgets/widgets/heart_button.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';

class VendorProductCard extends StatelessWidget {
  final VendorProductEntity product;
  final CartCubit cartCubit;
  final bool isDark;
  final Color mainColor;

  const VendorProductCard({
    super.key,
    required this.product,
    required this.cartCubit,
    required this.isDark,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAddingToCart = cartCubit.loadingProductId == product.id;

    Color cardBgColor = isDark ? const Color(0xFF0F0F10) : AppColors.white;
    Color borderColor = isDark
        ? Colors.white.withOpacity(0.06)
        : AppColors.lightGrey.withOpacity(0.4);
    Color textColor = isDark ? AppColors.white : AppColors.black;
    Color subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: borderColor,
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── 1. Top Image Showcase Container ───
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.02)
                        : AppColors.lightGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(19.r),
                      topRight: Radius.circular(19.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(19.r),
                      topRight: Radius.circular(19.r),
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      imageUrl: product.imageUrl ?? "",
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => Icon(
                        Icons.image_not_supported_outlined,
                        size: 24.sp,
                        color: AppColors.grey.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),

                // Floating Rating Star on top left
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 11.sp,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          product.averageRating.toDouble().toString(),
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 8.5.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Floating Heart Button on top right
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                      color: (isDark ? const Color(0xFF0F0F10) : Colors.white)
                          .withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                      builder: (context, state) {
                        return HeartButton(
                          width: 20.w,
                          height: 20.h,
                          isTapped: context
                              .watch<FavouriteCubit>()
                              .favoritesIds
                              .contains(product.id),
                          onTap: () {
                            context
                                .read<FavouriteCubit>()
                                .toggleFavorite(product.id);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─── 2. Product Information Footer ───
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: textColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 12.5.sp,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 2.h),

                // Product Short Description
                Text(
                  product.description.isNotEmpty
                      ? product.description
                      : "Premium curated option",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    color: subtitleColor.withOpacity(0.85),
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 8.h),

                // Price and Interactive Shopping Cart Action Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${product.price} EGP",
                        style: GoogleFonts.shareTechMono(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
