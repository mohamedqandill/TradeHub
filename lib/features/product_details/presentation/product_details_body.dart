import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/product_details/data/models/response/product_details_response_d_t_o.dart';
import 'package:tradehub/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:tradehub/features/product_details/presentation/widgets/product_options_widget.dart';
import 'package:tradehub/features/product_details/presentation/widgets/product_options_selection_widget.dart';
import 'package:tradehub/features/product_details/presentation/widgets/product_review_card.dart';
import 'package:tradehub/features/product_ratings/presentation/cubit/product_ratings_cubit.dart';
import 'package:tradehub/features/product_ratings/presentation/cubit/product_ratings_states.dart';

class ProductDetailsBody extends StatefulWidget {
  final ProductDetailsCubit cubit;
  const ProductDetailsBody({super.key, required this.cubit});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  int _selectedOptionsExtraPrice = 0;
  // int _currentImageIndex = 0;
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
                CachedNetworkImage(
                  imageUrl: product?.imageUrl ?? _images[0],
                  width: double.infinity,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported_outlined,
                    size: 50.sp,
                    color: AppColors.grey,
                  ),
                ),
                // Positioned(
                //   bottom: 20.h,
                //   left: 0,
                //   right: 0,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: _images.asMap().entries.map((entry) {
                //       return AnimatedContainer(
                //         duration: const Duration(milliseconds: 300),
                //         width: _currentImageIndex == entry.key ? 24.w : 8.w,
                //         height: 8.h,
                //         margin: EdgeInsets.symmetric(horizontal: 4.w),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10.r),
                //           color: _currentImageIndex == entry.key
                //               ? context.mainColor
                //               : context.mainColor.withOpacity(0.2),
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),
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
                            product?.companyName?.toUpperCase() ?? "BRAND",
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
                        if (product?.isOfferActive == true &&
                            product?.hasOffer == true) ...[
                          // Strikethrough original price
                          Text(
                            "${(product?.price ?? 0) + _selectedOptionsExtraPrice} EGP",
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: context.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              decorationThickness: 4,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          // Final discounted price
                          Text(
                            "${(product!.finalPrice ?? 0) + _selectedOptionsExtraPrice} EGP",
                            style: GoogleFonts.manrope(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.green,
                            ),
                          ),
                        ] else ...[
                          Text(
                            "${(product?.price ?? 0) + _selectedOptionsExtraPrice} EGP",
                            style: GoogleFonts.manrope(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w900,
                              color: context.mainColor,
                            ),
                          ),
                        ],
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
                        product?.averageRating.toString() ?? "",
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

        // 2.3 Offer Banner (shown only when offer is active)
        if (product?.hasOffer == true && product?.isOfferActive == true) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: _ProductOfferBanner(product: product!),
            ),
          ),
        ],

        // 2.5 Selectable Product Options
        if (widget.cubit.productOptions != null &&
            widget.cubit.productOptions!.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: ProductOptionsSelectionWidget(
              options: widget.cubit.productOptions!,
              onSelectionChanged: (selectedOptions, extraPrice) {
                setState(() {
                  _selectedOptionsExtraPrice = extraPrice;
                  widget.cubit.selectedOptionValueIds =
                      selectedOptions.values.expand((x) => x).toList();
                });
              },
            ),
          ),
        ],

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
        if (product?.attributes?.isNotEmpty ?? false) ...[
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
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
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
                  final attr = product?.attributes![index];
                  return ProductOptionWidget(
                    categoryAttName: attr?.categoryAttributeName ?? "",
                    value: attr?.value ?? "",
                  ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1);
                },
                childCount: product?.attributes?.length ?? 0,
              ),
            ),
          ),
        ],

        // 5. Reviews Section
        SliverPadding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
          sliver: SliverToBoxAdapter(
            child: Text(
              "REVIEWS",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
          ),
        ),
        BlocBuilder<ProductRatingsCubit, ProductRatingsStates>(
          builder: (context, state) {
            final ratingsCubit = context.read<ProductRatingsCubit>();
            final ratings = ratingsCubit.productRatings;

            if (state is GetProductRatingsLoadingState && ratings.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              );
            }

            if (state is GetProductRatingsErrorState && ratings.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    state.message,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }

            if (ratings.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "No reviews yet.",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList.separated(
                itemCount: ratings.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return ProductReviewCard(rating: ratings[index])
                      .animate()
                      .fadeIn(delay: (index * 50).ms)
                      .slideY(begin: 0.1);
                },
              ),
            );
          },
        ),

        // 5. Spacer for Bottom Bar
        SliverToBoxAdapter(
          child: SizedBox(height: 100.h),
        ),
      ],
    );
  }
}

// ─────────────────── OFFER BANNER WIDGET ───────────────────

class _ProductOfferBanner extends StatefulWidget {
  final ProductDetailsResponseDTO product;
  const _ProductOfferBanner({required this.product});

  @override
  State<_ProductOfferBanner> createState() => _ProductOfferBannerState();
}

class _ProductOfferBannerState extends State<_ProductOfferBanner> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calcRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        _calcRemaining();
      }
    });
  }

  void _calcRemaining() {
    final endDateStr = widget.product.offerEndDate;
    if (endDateStr == null) return;
    final endDate = DateTime.tryParse(endDateStr);
    if (endDate == null) return;
    final now = DateTime.now();
    final diff = endDate.difference(now);
    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isDark = context.isDarkMode;
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24);
    final minutes = _remaining.inMinutes.remainder(60);
    final seconds = _remaining.inSeconds.remainder(60);
    final isExpired = _remaining == Duration.zero;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    Colors.green.shade900.withOpacity(0.5),
                    Colors.teal.shade900.withOpacity(0.4),
                  ]
                : [
                    Colors.green.shade50,
                    Colors.teal.shade50,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.green.withOpacity(isDark ? 0.3 : 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.local_offer_rounded,
                    color: Colors.green,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "LIMITED TIME OFFER",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.green,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                // Discount badge
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    "${product.discountPercentage ?? 0}% OFF",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            // Price Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Original Price",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${product.price ?? 0} EGP",
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Container(
                  width: 1,
                  height: 32.h,
                  color: Colors.green.withOpacity(0.2),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Offer Price",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${product.finalPrice ?? 0} EGP",
                      style: GoogleFonts.manrope(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "You save\n${(product.price ?? 0) - (product.finalPrice ?? 0)} EGP",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            // Divider
            Divider(
              color: Colors.green.withOpacity(0.15),
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: 12.h),

            // Countdown Timer
            Row(
              children: [
                Icon(
                  isExpired ? Icons.timer_off_rounded : Icons.timer_rounded,
                  color: isExpired ? Colors.red : Colors.green,
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  isExpired ? "Offer Ended" : "Ends In:",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: isExpired
                        ? Colors.red
                        : (isDark ? Colors.white70 : Colors.black54),
                  ),
                ),
                SizedBox(width: 12.w),
                if (!isExpired) ...[
                  _CountdownUnit(label: "D", value: _pad(days)),
                  SizedBox(width: 4.w),
                  _CountdownSeparator(),
                  SizedBox(width: 4.w),
                  _CountdownUnit(label: "H", value: _pad(hours)),
                  SizedBox(width: 4.w),
                  _CountdownSeparator(),
                  SizedBox(width: 4.w),
                  _CountdownUnit(label: "M", value: _pad(minutes)),
                  SizedBox(width: 4.w),
                  _CountdownSeparator(),
                  SizedBox(width: 4.w),
                  _CountdownUnit(label: "S", value: _pad(seconds)),
                ],
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  final String label;
  final String value;
  const _CountdownUnit({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w900,
              color: Colors.green,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w700,
              color: Colors.green.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  const _CountdownSeparator();

  @override
  Widget build(BuildContext context) {
    return Text(
      ":",
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w900,
        color: Colors.green.withOpacity(0.6),
      ),
    );
  }
}
