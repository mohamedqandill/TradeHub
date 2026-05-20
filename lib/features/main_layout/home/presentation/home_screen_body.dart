import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_search_field.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/category_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/custom_row_headline.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_header_widget.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_offer_card.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/product_card.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/products_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/vendors_section.dart';
import 'package:tradehub/main.dart';
import '../../../../Core/colors/app_colors.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> with RouteAware {
  late final ScrollController _scrollController;
  late String address;
  late HomeCubit cubit;

  // Search State & Transition variables
  bool _isSearchActive = false;
  String _searchQuery = "";
  List<GetRandomProductEntity> _searchResults = [];
  Timer? _debounceTimer;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void didPopNext() {
    var repo = getIt<SharedProductRepository>();
    if (repo.hasUpdates) {
      context.read<HomeCubit>().getRandomProducts(isRefresh: true);
      repo.clearUpdates();
    }
    super.didPopNext();
  }

  @override
  void initState() {
    super.initState();
    getSavedPlaceName();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounceTimer?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeCubit>().getRandomProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  getSavedPlaceName() {
    address = getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ??
        "No Place Selected";
  }

  void updateAddress() {
    setState(() {
      getSavedPlaceName();
    });
  }

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query.trim();
        if (_searchQuery.isEmpty) {
          _searchResults = [];
        } else {
          final homeCubit = context.read<HomeCubit>();
          _searchResults = homeCubit.allLocalProducts.where((product) {
            final nameMatch = product.name
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false;
            final descMatch = product.description
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false;
            final sellerMatch = product.companyName
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false;
            return nameMatch || descMatch || sellerMatch;
          }).toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    Color scaffoldBg = isDarkMode ? AppColors.black : Colors.white;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.getRandomProductsState == RequestStates.success) {
          context.read<FavouriteCubit>().setFavorites(
                state.randomProducts
                    .where((e) => e.isFavourite == true)
                    .map((e) => e.id)
                    .toList(),
              );
        }
      },
      builder: (context, state) {
        cubit = context.watch<HomeCubit>();

        if (state.getCategoryState == RequestStates.error &&
            state.getCompaniesState == RequestStates.error &&
            state.getRandomProductsState == RequestStates.error) {
          return CustomErrorWidget(
            message: state.errorMessage ?? "Failed to load home data.",
            onRetry: () => cubit.revokeHomeApis(),
          );
        }

        return WillPopScope(
          onWillPop: () async {
            if (_isSearchActive) {
              setState(() {
                _isSearchActive = false;
                _searchQuery = "";
                _searchController.clear();
                _searchFocusNode.unfocus();
              });
              return false;
            }
            return true;
          },
          child: Stack(
            children: [
              // Main Home Scrollable Listing
              RefreshIndicator(
                onRefresh: () async {
                 getSavedPlaceName();
                 await   cubit.getRandomProducts();
                },
                child: ListView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    HomeHeaderWidget(
                      address: address,
                      onPlaceSelected: updateAddress,
                      onSearchTap: () {
                        setState(() {
                          _isSearchActive = true;
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _searchFocusNode.requestFocus();
                        });
                      },
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRowHeadline(
                            title: LocaleKeys.categories.tr(),
                            subTitle: "",
                          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                          SizedBox(height: 6.h),
                          CategorySection(
                            cubit: cubit,
                            isLoading:
                                state.getCategoryState == RequestStates.loading,
                          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                          SizedBox(height: 26.h),
                          const HomeOfferCard()
                              .animate()
                              .fadeIn(delay: 400.ms)
                              .scale(begin: const Offset(0.95, 0.95)),
                          SizedBox(height: 28.h),
                          CustomRowHeadline(
                            title: LocaleKeys.featuredVendors.tr(),
                            subTitle: "",
                          ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2),
                          SizedBox(height: 6.h),
                          VendorsSection(
                            isLoading: state.getCompaniesState ==
                                RequestStates.loading,
                            cubit: cubit,
                          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                          SizedBox(height: 36.h),
                          CustomRowHeadline(
                            title: LocaleKeys.popularProducts.tr(),
                            subTitle: "",
                          ).animate().fadeIn(delay: 700.ms).slideX(begin: -0.2),
                          SizedBox(height: 6.h),
                          ProductsSection(
                            isLoading: state.getRandomProductsState ==
                                RequestStates.loading,
                          ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
                          if (state.isFetchingMoreProducts)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Full-Screen Search View Overlay & Transitions
              if (_isSearchActive)
                Positioned.fill(
                  child: Container(
                    color: scaffoldBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search bar header positioned at the top of the search view
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).viewPadding.top + 12.h,
                            left: 8.w,
                            right: 16.w,
                            bottom: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppColors.black : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 20.sp,
                                  color: context.mainColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isSearchActive = false;
                                    _searchQuery = "";
                                    _searchController.clear();
                                    _searchFocusNode.unfocus();
                                  });
                                },
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                  child: CustomSearchField(
                                    controller: _searchController,
                                    focusNode: _searchFocusNode,
                                    autofocus: true,
                                    onChanged: _onSearchChanged,
                                    fillColor: isDarkMode
                                        ? Colors.white.withOpacity(0.05)
                                        : AppColors.grey.withOpacity(0.08),
                                    borderColor: isDarkMode
                                        ? Colors.white.withOpacity(0.1)
                                        : AppColors.lightGrey,
                                    hintColor: isDarkMode
                                        ? Colors.white54
                                        : AppColors.grey.withOpacity(0.6),
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      size: 22.sp,
                                      color: context.mainColor,
                                    ),
                                    suffixIcon:
                                        _searchController.text.isNotEmpty
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.clear_rounded,
                                                  size: 20.sp,
                                                  color: isDarkMode
                                                      ? Colors.white70
                                                      : Colors.black54,
                                                ),
                                                onPressed: () {
                                                  _searchController.clear();
                                                  _onSearchChanged("");
                                                },
                                              )
                                            : null,
                                    hintText: "Search products, brands...",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: _searchQuery.isEmpty
                              ? _buildSearchDescription(context)
                              : _searchResults.isEmpty
                                  ? _buildNotFoundWidget(context)
                                  : _buildSearchResultsList(context),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 300.ms)
                      .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                ),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────── WHITE SEARCH DESCRIPTION SCREEN ───────────────────
  Widget _buildSearchDescription(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    return Container(
      width: double.infinity,
      color: isDarkMode ? AppColors.black : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.sp),
            decoration: BoxDecoration(
              color: context.mainColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_rounded,
              size: 64.sp,
              color: context.mainColor,
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.bounceOut),
          SizedBox(height: 24.h),
          Text(
            "Discover Premium Products",
            style: context.base.theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Search trade items, specific store vendors, categories or brands instantly.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 13.sp,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────── NOT FOUND WIDGET ───────────────────
  Widget _buildNotFoundWidget(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    return Container(
      width: double.infinity,
      color: isDarkMode ? AppColors.black : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.sp),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: Colors.red.shade400,
            ),
          ).animate().shake(duration: 500.ms),
          SizedBox(height: 24.h),
          Text(
            "No Matching Products Found",
            style: context.base.theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "We couldn't find any products matching '$_searchQuery'. Try checking spelling or search other terms.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 13.sp,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────── SEARCH RESULTS DISPLAY LIST ───────────────────
  Widget _buildSearchResultsList(BuildContext context) {
    var cartCubit = context.watch<CartCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is AddToCartSuccessState) {
              showSuccessSnackBar(messageTitle: "Added To Cart");
            }
            if (state is AddToCartErrorState) {
              showFailureSnackBar(context, messageTitle: "Failed");
            }
          },
        ),
      ],
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        physics: const BouncingScrollPhysics(),
        itemCount: _searchResults.length,
        separatorBuilder: (context, index) => SizedBox(height: 14.h),
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          return ProductCard(
            product: product,
            cartCubit: cartCubit,
            isDark: context.isDarkMode,
            mainColor: context.mainColor,
          );
        },
      ),
    );
  }
}
