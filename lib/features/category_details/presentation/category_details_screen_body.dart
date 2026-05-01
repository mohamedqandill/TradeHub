import 'package:flutter/material.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover vendors in ${args.categoryName}",
                style: context.base.theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: (context.isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade600)
                      .withOpacity(0.95),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              // const FilterRowWidget(),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.companies.length,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                        enabled:
                            state.getCompaniesState == RequestStates.loading,
                        child:
                            VendorCardWidget(company: cubit.companies[index]));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
