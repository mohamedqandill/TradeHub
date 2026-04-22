import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/assets/app_assets.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:tradehub/features/product_details/presentation/widgets/product_options_widget.dart';

import '../../../core/assets/assets.gen.dart';

class ProductDetailsBody extends StatefulWidget {
  final ProductDetailsCubit cubit;
  const ProductDetailsBody({super.key, required this.cubit});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  int _currentImageIndex = 0;
  final List<String> _images = [
    "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
    "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
    "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.cubit.productDetails;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // 1. Header Image Carousel
        SliverToBoxAdapter(
          child: Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? AppColors.black.withOpacity(0.5)
                  : AppColors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            child: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300.h,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() => _currentImageIndex = index);
                    },
                  ),
                  items: _images.map((url) {
                    return CachedNetworkImage(
                      imageUrl: url,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image_not_supported_outlined,
                        size: 50.sp,
                        color: AppColors.grey,
                      ),
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 20.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _images.asMap().entries.map((entry) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _currentImageIndex == entry.key ? 24.w : 8.w,
                        height: 8.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: _currentImageIndex == entry.key
                              ? context.mainColor
                              : context.mainColor.withOpacity(0.2),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),

        // 2. Product Basic Info
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product?.companyName.toUpperCase() ?? "BRAND",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              color: context.mainColor,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            product?.name ?? "Product Name",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w900,
                              color: context.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${product?.price ?? 0} EGP",
                          style: GoogleFonts.manrope(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            color: context.mainColor,
                          ),
                        ),
                        Text(
                          "Tax Incl.",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Rating Bar
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: context.mainColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded,
                          color: Colors.amber, size: 20.sp),
                      SizedBox(width: 4.w),
                      Text(
                        product?.averageRating.toString() ?? "0.0",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 1,
                        height: 12.h,
                        color: AppColors.grey.withOpacity(0.2),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "${product?.ratingCount ?? 0} Reviews",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // 3. Description Section
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 20.w),
        //     child: Theme(
        //       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        //       child: ExpansionTile(
        //         initiallyExpanded: true,
        //         tilePadding: EdgeInsets.zero,
        //         title: Text(
        //           "DESCRIPTION",
        //           style: TextStyle(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w900,
        //             letterSpacing: 1.5,
        //             color: context.isDarkMode ? AppColors.white : AppColors.black,
        //           ),
        //         ),
        //         children: [
        //           Padding(
        //             padding: EdgeInsets.only(bottom: 16.h),
        //             child: Text(
        //               product?.description ?? "No description available.",
        //               style: TextStyle(
        //                 fontSize: 14.sp,
        //                 color: AppColors.grey,
        //                 height: 1.6,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        // 4. Attributes Grid
        if (product?.attributes.isNotEmpty ?? false) ...[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text(
                  "SPECIFICATIONS",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 2.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final attr = product.attributes[index];
                  return ProductOptionWidget(
                    categoryAttName: attr.categoryAttributeName,
                    value: attr.value,
                  );
                },
                childCount: product!.attributes.length,
              ),
            ),
          ),
        ],

        // 5. Spacer for Bottom Bar
        SliverToBoxAdapter(
          child: SizedBox(height: 100.h),
        ),
      ],
    );
  }
}
