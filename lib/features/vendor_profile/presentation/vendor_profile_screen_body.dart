import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/shared_widgets/widgets/arrow_back_widget.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/product_card.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_cubit.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_states.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/sliver_category_delegate.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/vendor_category_pills.dart';

import '../../../core/functions/show_snakbar.dart';
import '../../../core/utils/animations/loading_product_animation.dart';

class VendorProfileScreenBody extends StatelessWidget {
  const VendorProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.isDarkMode;

    return BlocBuilder<VendorProfileCubit, VendorProfileStates>(
      builder: (context, state) {
        final cubit = context.read<VendorProfileCubit>();
        final vendor = cubit.vendorDetails;

        if (state is GetVendorDetailsLoadingState) {
          return Scaffold(
            body: loadingProductAnimation(),
          );
        }

        if (state is GetVendorDetailsErrorState) {
          final vendorId =
              ModalRoute.of(context)?.settings.arguments as String? ?? "";
          return Scaffold(
            body: CustomErrorWidget(
              message: (state).error,
              onRetry: () {
                cubit.getVendorDetails(vendorId);
                cubit.getVendorSubcategories(vendorId);
              },
            ),
          );
        }

        if (vendor == null) {
          return Scaffold(
            body: loadingProductAnimation(),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // 1. Single Premium Image Header (Full bleed parallax showcase)
              SliverAppBar(
                expandedHeight: 195.h,
                pinned: true,
                stretch: true,
                leadingWidth: 60.w,
                leading: const ArrowBackWidget(),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: vendor.logoUrl.isNotEmpty
                            ? vendor.logoUrl
                            : "https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2148153401.jpg",
                        fit: BoxFit.contain, // Single full-bleed hero banner
                        errorWidget: (_, __, ___) => Image.network(
                          "https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2148153401.jpg",
                          fit: BoxFit.contain,
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                              Colors.black.withOpacity(0.65),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Redesigned flat store branding layout underneath the single image
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              vendor.businessName.isNotEmpty
                                  ? vendor.businessName
                                  : "Premium Boutique",
                              style: GoogleFonts.outfit(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                                color: isDarkMode ? Colors.white : Colors.black,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  color: Colors.green,
                                  size: 11.sp,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  "Verified",
                                  style: GoogleFonts.outfit(
                                    color: Colors.green,
                                    fontSize: 8.5.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: context.mainColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              vendor.businessTypeName.isNotEmpty
                                  ? vendor.businessTypeName
                                  : "Retail",
                              style: GoogleFonts.outfit(
                                color: context.mainColor,
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.location_on_rounded,
                            color: context.mainColor,
                            size: 13.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              vendor.locationName.isNotEmpty
                                  ? vendor.locationName
                                  : "Cairo, Egypt",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.06)
                            : Colors.grey.shade100,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 18.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "4.9",
                            style: GoogleFonts.outfit(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "(1,280 reviews)",
                            style: GoogleFonts.outfit(
                              color:
                                  isDarkMode ? Colors.white60 : Colors.black54,
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
              ),

              // 3. Sticky Category Pills Section
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverCategoryDelegate(
                  child: BlocBuilder<VendorProfileCubit, VendorProfileStates>(
                    builder: (context, state) {
                      final cubit = context.read<VendorProfileCubit>();

                      if (state is GetVendorSubcategoriesLoadingState) {
                        return const SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return VendorCategoryPills(
                        categories:
                            cubit.subcategories.map((e) => e.name).toList(),
                        onCategorySelected: (index) {
                          if (cubit.subcategories.isNotEmpty &&
                              index < cubit.subcategories.length) {
                            cubit.getProductsBySubcategory(
                                cubit.subcategories[index].id);
                          }
                        },
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1);
                    },
                  ),
                ),
              ),

              // 4. Products Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
                  child: Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 18.h,
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.mainColor,
                              context.mainColor.withOpacity(0.4),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      Text(
                        cubit.subcategories.isNotEmpty
                            ? cubit.subcategories
                                .firstWhere((e) => e.id == cubit.subCategoryId,
                                    orElse: () => cubit.subcategories.first)
                                .name
                            : "Products",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w900,
                          fontSize: 19.sp,
                          color: isDarkMode ? Colors.white : Colors.black,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2),
              ),

              // 5. Active Subcategory Products Section (Vertical stack of original horizontal ProductCards!)
              if (state is GetProductsBySubcategoryLoadingState)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = cubit.products[index];

                        // Transform VendorProductEntity to GetRandomProductEntity on the fly to support horizontal ProductCard
                        final mappedProduct = GetRandomProductEntity(
                          id: product.id,
                          name: product.name,
                          description: product.description,
                          price: product.price,
                          quantity: product.quantity,
                          categoryId: null,
                          categoryName: product.categoryName,
                          companyId: vendor.id,
                          companyName: vendor.businessName,
                          imageUrl: product.imageUrl,
                          logoUrl: vendor.logoUrl,
                          averageRating: product.averageRating,
                          ratingCount: product.ratingCount,
                          isFavourite: product.isFavourite,
                          hasOffer: product.hasOffer,
                          isOfferActive: product.isOfferActive,
                          discountPercentage: product.discountPercentage,
                          offerStartDate: product.offerStartDate,
                          offerEndDate: product.offerEndDate,
                          finalPrice: product.finalPrice,
                          attributes: product.attributes
                              .map((attr) => {
                                    'categoryAttributeName': attr.name,
                                    'value': attr.value,
                                  })
                              .toList(),
                        );

                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: ProductCard(
                            product: mappedProduct,
                            cartCubit: context.read<CartCubit>(),
                            isDark: isDarkMode,
                            mainColor: context.mainColor,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: (500 + index * 50).ms)
                            .slideY(begin: 0.1);
                      },
                      childCount: cubit.products.length,
                    ),
                  ),
                ),

              // Bottom padding
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          ),
        );
      },
    );
  }
}
