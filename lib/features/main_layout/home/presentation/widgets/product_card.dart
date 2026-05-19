import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/widgets/heart_button.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';

class ProductCard extends StatelessWidget {
  final GetRandomProductEntity product;
  final CartCubit cartCubit;
  final bool isDark;
  final Color mainColor;

  const ProductCard({
    super.key,
    required this.product,
    required this.cartCubit,
    required this.isDark,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final int rating = product.averageRating ?? 0;
    final bool isAddingToCart = cartCubit.loadingProductId == product.id;

    // Premium Color System
    Color cardBgColor = isDark ? const Color(0xFF0A0A0B) : AppColors.white;
    Color borderColor = isDark
        ? Colors.white.withOpacity(0.06)
        : AppColors.lightGrey.withOpacity(0.8);
    Color textColor = isDark ? AppColors.white : AppColors.black;
    Color subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: product.id,
        );
      },
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: borderColor,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Image Column (Left) ───
            _buildImageSection(context),
            SizedBox(width: 14.w),

            // ─── Info Column (Right) ───
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vendor & Category
                  _buildVendorHeader(context, subtitleColor),
                  SizedBox(height: 6.h),

                  // Title (Luxury Typography)
                  Text(
                    product.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Description
                  if (product.description?.isNotEmpty == true)
                    Text(
                      product.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        color: subtitleColor.withOpacity(0.8),
                        fontSize: 11.sp,
                        height: 1.2,
                      ),
                    ),
                  SizedBox(height: 8.h),

                  // Attributes Section
                  _buildAttributesSection(isDark),
                  SizedBox(height: 8.h),

                  // Rating Row & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRatingRow(rating, product.ratingCount ?? 0, subtitleColor),
                      Text(
                        "${product.price ?? 0} EGP",
                        style: GoogleFonts.shareTechMono(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  // Bottom Action Button (Full Width within info col)
                  _buildBottomAction(context, isAddingToCart),
                ],
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
        // Product Image Container
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            height: 145.h,
            width: 115.w,
            color: isDark
                ? Colors.white.withOpacity(0.03)
                : AppColors.lightGrey.withOpacity(0.4),
            child: CachedNetworkImage(
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              fit: BoxFit.contain,
              imageUrl: (product.imageUrl?.isNotEmpty == true)
                  ? product.imageUrl!
                  : "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
              errorWidget: (context, url, error) => Icon(
                Icons.image_not_supported_outlined,
                size: 28.sp,
                color: AppColors.grey.withOpacity(0.4),
              ),
            ),
          ),
        ),

        // Glassmorphic Favourite Button overlay
        Positioned(
          top: 8.h,
          right: 8.w,
          child: Container(
            padding: EdgeInsets.all(3.sp),
            decoration: BoxDecoration(
              color: (isDark ? const Color(0xFF0A0A0B) : Colors.white).withOpacity(0.9),
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
                  width: 22.w,
                  height: 22.h,
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

  Widget _buildVendorHeader(BuildContext context, Color subtitleColor) {
    return Row(
      children: [
        if (product.logoUrl?.isNotEmpty == true)
          Container(
            margin: EdgeInsets.only(right: 6.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? Colors.white24 : Colors.black12,
                width: 1,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: product.logoUrl!,
                width: 20.w,
                height: 20.w,
                fit: BoxFit.contain,
                errorWidget: (c, u, e) => const SizedBox(),
              ),
            ),
          ),
        Expanded(
          child: Text(
            product.companyName?.isNotEmpty == true
                ? product.companyName!
                : "Official Store",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: subtitleColor,
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        _buildCategoryBadge(context),
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
        color: mainColor.withOpacity(isDark ? 0.16 : 0.08),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        categoryText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.manrope(
          color: mainColor,
          fontSize: 8.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  Widget _buildAttributesSection(bool isDark) {
    if (product.attributes == null || product.attributes!.isEmpty) {
      return const SizedBox();
    }

    return Wrap(
      spacing: 6.w,
      runSpacing: 4.h,
      children: product.attributes!.take(3).map((attr) {
        String name = '';
        String val = '';
        if (attr is Map) {
          name = attr['categoryAttributeName']?.toString() ?? '';
          val = attr['value']?.toString() ?? '';
        }
        if (val.isEmpty) return const SizedBox();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.04)
                : Colors.black.withOpacity(0.03),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
              width: 0.5,
            ),
          ),
          child: Text(
            "$name: $val",
            style: GoogleFonts.manrope(
              color: isDark ? Colors.white70 : Colors.black87,
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRatingRow(int rating, int ratingCount, Color subtitleColor) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          size: 14.sp,
          color: const Color(0xffFFC107),
        ),
        SizedBox(width: 2.w),
        Text(
          rating.toDouble().toString(),
          style: GoogleFonts.manrope(
            color: isDark ? Colors.white70 : Colors.black87,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          "($ratingCount)",
          style: GoogleFonts.manrope(
            color: subtitleColor.withOpacity(0.6),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context, bool isAddingToCart) {
    // Elegant luxury linear gradient blend utilizing mainColor
    final Gradient premiumGradient = LinearGradient(
      colors: [
        mainColor,
        Color.lerp(mainColor, Colors.white, isDark ? 0.15 : 0.25)!,
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isAddingToCart
            ? null
            : () {
                cartCubit.addToCart(product.id ?? 0);
              },
        borderRadius: BorderRadius.circular(10.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            gradient: premiumGradient,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: mainColor.withOpacity(isDark ? 0.25 : 0.18),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: isAddingToCart
              ? SizedBox(
                  width: 14.sp,
                  height: 14.sp,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "ADD TO CART",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
