import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/shared_widgets/widgets/arrow_back_widget.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/product_card.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_cubit.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_states.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/sliver_category_delegate.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/vendor_category_pills.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/sticky_tab_bar_delegate.dart';
import 'package:tradehub/features/product_details/presentation/widgets/product_review_card.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';

import '../../../core/utils/animations/loading_product_animation.dart';

class VendorProfileScreenBody extends StatefulWidget {
  const VendorProfileScreenBody({super.key});

  @override
  State<VendorProfileScreenBody> createState() =>
      _VendorProfileScreenBodyState();
}

class _VendorProfileScreenBodyState extends State<VendorProfileScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                cubit.getCompanyRatings(vendorId);
              },
            ),
          );
        }

        if (vendor == null) {
          return Scaffold(
            body: loadingProductAnimation(),
          );
        }

        final double averageRating = cubit.companyRatings.isEmpty
            ? 0.0
            : cubit.companyRatings
                    .map((r) => r.ratingValue ?? 0)
                    .reduce((a, b) => a + b) /
                cubit.companyRatings.length;
        final int reviewCount = cubit.companyRatings.length;

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
                            (vendor.avgRating??0).toStringAsFixed(1),
                            style: GoogleFonts.outfit(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "(${vendor.reviewCount} reviews)",
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

              // Tab Bar for switching between Products and Reviews
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  tabBar: TabBar(
                    controller: _tabController,
                    indicatorColor: context.mainColor,
                    labelColor: context.mainColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                    ),
                    unselectedLabelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    tabs: const [
                      Tab(text: "Products"),
                      Tab(text: "Reviews"),
                    ],
                  ),
                ),
              ),

              if (_tabController.index == 0) ...[
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
                                  .firstWhere(
                                      (e) => e.id == cubit.subCategoryId,
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

                // 5. Active Subcategory Products Section
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
              ] else ...[
                // Reviews Section Tab
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                              "REVIEWS ($reviewCount)",
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w900,
                                fontSize: 19.sp,
                                color: isDarkMode ? Colors.white : Colors.black,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.mainColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () => _showAddRatingSheet(
                            context,
                            companyId: vendor.id,
                            cubit: cubit,
                          ),
                          icon: Icon(Icons.rate_review_outlined, size: 16.sp),
                          label: Text(
                            "Add Rating",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w800,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2),
                  ),
                ),

                if (state is GetCompanyRatingsLoadingState &&
                    cubit.companyRatings.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                else if (cubit.companyRatings.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 40.h),
                      child: Center(
                        child: Text(
                          "No reviews yet. Be the first to review!",
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index.isOdd) {
                            return SizedBox(height: 12.h);
                          }
                          final itemIndex = index ~/ 2;
                          return ProductReviewCard(
                              rating: cubit.companyRatings[itemIndex]);
                        },
                        childCount: cubit.companyRatings.length * 2 - 1,
                      ),
                    ),
                  ),
              ],

              // Bottom padding
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showAddRatingSheet(BuildContext context,
      {required String companyId, required VendorProfileCubit cubit}) async {
    final commentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    int ratingValue = 5;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final bottomPadding = MediaQuery.of(ctx).viewInsets.bottom;
        return BlocProvider.value(
          value: cubit,
          child: StatefulBuilder(
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

              return BlocConsumer<VendorProfileCubit, VendorProfileStates>(
                listener: (context, state) {
                  if (state is AddCompanyRatingSuccessState) {
                    Navigator.pop(ctx);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AddCompanyRatingLoadingState;

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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(28.r)),
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
                                        borderRadius:
                                            BorderRadius.circular(99.r),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 14.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Rate this vendor",
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
                                          color:
                                              AppColors.grey.withOpacity(0.75),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  horizontal: 10.w,
                                                  vertical: 6.h),
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
                                                  color:
                                                      const Color(0xffFFC107),
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
                                      hintText:
                                          "Tell us what you liked (or not).",
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: ctx.isDarkMode
                                          ? Colors.white.withOpacity(0.06)
                                          : AppColors.grey.withOpacity(0.06),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.r),
                                        borderSide:
                                            BorderSide(color: borderColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.r),
                                        borderSide:
                                            BorderSide(color: borderColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.r),
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
                                      if (text.isEmpty)
                                        return "Comment is required";
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 14.h),
                                            side:
                                                BorderSide(color: borderColor),
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
                                                      commentController.text
                                                          .trim();
                                                  await cubit.addCompanyRating(
                                                    companyId: companyId,
                                                    ratingValue: ratingValue,
                                                    comment: comment,
                                                  );
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
          ),
        );
      },
    );
  }
}
