import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/utils/animations/loading_product_animation.dart';
import 'package:tradehub/features/category_details/presentation/category_details_args.dart';
import 'package:tradehub/features/category_details/presentation/cubit/category_details_cubit.dart';
import 'package:tradehub/main.dart';

import 'widgets/category_premium_header.dart';
import 'widgets/vendor_card_widget.dart';

class CategoryDetailsScreenBody extends StatelessWidget {
  final CategoryDetailsArgs args;
  const CategoryDetailsScreenBody({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
      builder: (context, state) {
        final cubit = context.watch<CategoryDetailsCubit>();

        if (state.getCompaniesState == RequestStates.loading) {
          return loadingProductAnimation();
        }

        if (state.getCompaniesState == RequestStates.error) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                state.errorMessage ?? "Failed to load companies",
                textAlign: TextAlign.center,
                style: context.base.theme.textTheme.bodyMedium?.copyWith(
                  color: context.isDarkMode ? AppColors.white : AppColors.black,
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryPremiumHeader(
                categoryName: args.categoryName,
                vendorCount: cubit.companies.length,
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.08),
              SizedBox(height: 20.h),
              Expanded(
                child: cubit.companies.isEmpty
                    ? _buildEmptyVendors(context)
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.companies.length,
                        separatorBuilder: (_, __) => SizedBox(height: 14.h),
                        itemBuilder: (context, index) {
                          return Skeletonizer(
                            enabled:
                                state.getCompaniesState == RequestStates.loading,
                            child: VendorCardWidget(
                              company: cubit.companies[index],
                            )
                                .animate()
                                .fadeIn(delay: (index * 50).ms)
                                .slideY(begin: 0.08),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyVendors(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.storefront_outlined,
              size: 56.sp,
              color: context.isDarkMode ? Colors.white24 : AppColors.grey,
            ),
            SizedBox(height: 16.h),
            Text(
              'No vendors in ${args.categoryName} yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color:
                    context.isDarkMode ? AppColors.white : AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
