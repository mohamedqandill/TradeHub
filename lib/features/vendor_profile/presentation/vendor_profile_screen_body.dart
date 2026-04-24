import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/widgets/arrow_back_widget.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_cubit.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_states.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/vendor_info_card.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/vendor_search_bar.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/vendor_category_pills.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/product_card_vertical.dart';
import 'package:tradehub/features/vendor_profile/presentation/widgets/product_card_horizontal.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';

class VendorProfileScreenBody extends StatefulWidget {
  const VendorProfileScreenBody({super.key});

  @override
  State<VendorProfileScreenBody> createState() =>
      _VendorProfileScreenBodyState();
}

class _VendorProfileScreenBodyState extends State<VendorProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorProfileCubit, VendorProfileStates>(
        builder: (context, state) {
      final cubit = context.read<VendorProfileCubit>();
      final vendor = cubit.vendorDetails;

      if (state is GetVendorDetailsLoadingState) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (state is GetVendorDetailsErrorState) {
        final vendorId =
            ModalRoute.of(context)?.settings.arguments as String? ?? "";
        return Scaffold(
          body: CustomErrorWidget(
            message: (state as GetVendorDetailsErrorState).error,
            onRetry: () {
              cubit.getVendorDetails(vendorId);
              cubit.getVendorSubcategories(vendorId);
            },
          ),
        );
      }

      if (vendor == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            // 1. Premium Collapsing App Bar
            SliverAppBar(
              expandedHeight: 180.h,
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
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      vendor.logoUrl.isNotEmpty
                          ? vendor.logoUrl
                          : "https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2148153401.jpg",
                      fit: BoxFit.fill,
                      errorBuilder: (_, __, ___) => Image.network(
                          "https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2148153401.jpg",
                          fit: BoxFit.cover),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Overlapping Vendor Info Card
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(0, -10.h),
                child: VendorInfoCard(
                  title: vendor.businessName.isNotEmpty
                      ? vendor.businessName
                      : "Loading...",
                  image: vendor.logoUrl.isNotEmpty
                      ? vendor.logoUrl
                      : "https://th.bing.com/th/id/R.717ac84dfc2d28c634914f26a289340b?rik=ufWdL6Ud5vyiow&pid=ImgRaw&r=0",
                  rating: "4.5",
                  reviews: "(1,200 ${LocaleKeys.reviews.tr()})",
                  subTitle: vendor.businessTypeName.isNotEmpty
                      ? vendor.businessTypeName
                      : "",
                ),
              ),
            ),

            // // 3. Search Bar Section
            // const SliverToBoxAdapter(
            //   child: VendorSearchBar(),
            // ),

            // 4. Sticky Category Pills
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverCategoryDelegate(
                child: VendorCategoryPills(
                  categories: cubit.subcategories.map((e) => e.name).toList(),
                  onCategorySelected: (index) {
                    if (cubit.subcategories.isNotEmpty &&
                        index < cubit.subcategories.length) {
                      cubit.getProductsBySubcategory(
                          cubit.subcategories[index].id);
                    }
                  },
                ),
              ),
            ),

            // 5. 'Our Picks' Section (Horizontal)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
                child: Text(
                  "Our Picks",
                  style: context.base.theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 22.sp,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220.h,
                child: state is GetProductsBySubcategoryLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.products.length > 5
                            ? 5
                            : cubit.products.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16.w),
                        itemBuilder: (context, index) {
                          final product = cubit.products[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.productDetails,
                                  arguments: product.id);
                            },
                            child: ProductCardVertical(
                              title: product.name,
                              price: "${product.price} EGP",
                              image:
                                  "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
                            ),
                          );
                        },
                      ),
              ),
            ),

            // 6. 'Burgers' Section (Vertical List)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 10.h),
                child: Text(
                  cubit.subcategories.isNotEmpty
                      ? cubit.subcategories
                          .firstWhere((e) => e.id == cubit.subCategoryId,
                              orElse: () => cubit.subcategories.first)
                          .name
                      : "Products",
                  style: context.base.theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 22.sp,
                  ),
                ),
              ),
            ),
            if (state is GetProductsBySubcategoryLoadingState)
              const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()))
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = cubit.products[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.productDetails,
                            arguments: product.id);
                      },
                      child: ProductCardHorizontal(
                        title: product.name,
                        description: product.description.isNotEmpty
                            ? product.description
                            : "No description available.",
                        price: "${product.price} EGP",
                        image:
                            "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png",
                        rating: "5.0",
                        reviewSnippet: product.attributes.isNotEmpty
                            ? "${product.attributes.first.name}: ${product.attributes.first.value}"
                            : "No reviews yet.",
                      ),
                    );
                  },
                  childCount: cubit.products.length,
                ),
              ),

            // Bottom padding
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),
          ],
        ),
      );
    });
  }
}

class _SliverCategoryDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverCategoryDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => 60.h;

  @override
  double get minExtent => 60.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
