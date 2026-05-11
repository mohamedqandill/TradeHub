import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/category_section.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/custom_row_headline.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_header_widget.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_offer_card.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void didPopNext() {
    var repo = getIt<SharedProductRepository>();
    if (repo.hasUpdates) {
      context.read<HomeCubit>().getRandomProducts();
      repo.clearUpdates();
    }
    super.didPopNext();
  }

  late String address;
  @override
  void initState() {
    getSavedPlaceName();
    super.initState();
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

  late HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state.getRandomProductsState == RequestStates.success) {
        context.read<FavouriteCubit>().setFavorites(
              state.randomProducts
                  .where((e) => e.isFavourite == true)
                  .map((e) => e.id)
                  .toList(),
            );
      }
    }, builder: (context, state) {
      cubit = context.watch<HomeCubit>();

      if (state.getCategoryState == RequestStates.error &&
          state.getCompaniesState == RequestStates.error &&
          state.getRandomProductsState == RequestStates.error) {
        return CustomErrorWidget(
          message: state.errorMessage ?? "Failed to load home data.",
          onRetry: () => cubit.revokeHomeApis(),
        );
      }

      return ListView(
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          HomeHeaderWidget(
            address: address,
            onPlaceSelected: updateAddress,
          ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.categories.tr(),
                  style: context.base.theme.textTheme.titleLarge?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.black,
                    letterSpacing: -0.5,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                SizedBox(height: 16.h),
                CategorySection(
                  cubit: cubit,
                  isLoading: state.getCategoryState == RequestStates.loading,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                SizedBox(height: 12.h),
                const HomeOfferCard()
                    .animate()
                    .fadeIn(delay: 400.ms)
                    .scale(begin: const Offset(0.95, 0.95)),
                SizedBox(height: 15.h),
                CustomRowHeadline(
                  title: LocaleKeys.featuredVendors.tr(),
                  subTitle: "",
                ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2),
                SizedBox(height: 16.h),
                VendorsSection(
                  isLoading: state.getCompaniesState == RequestStates.loading,
                  cubit: cubit,
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                SizedBox(height: 32.h),
                CustomRowHeadline(
                  title: LocaleKeys.popularProducts.tr(),
                  subTitle: "",
                ).animate().fadeIn(delay: 700.ms).slideX(begin: -0.2),
                SizedBox(height: 16.h),
                ProductsSection(
                  isLoading:
                      state.getRandomProductsState == RequestStates.loading,
                ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      );
    });
  }
}
