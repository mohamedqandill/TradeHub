import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/product_sort_option.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';

Future<void> showProductSortBottomSheet(
  BuildContext context, {
  VoidCallback? onSortSelected,
}) {
  final cubit = context.read<HomeCubit>();
  final currentSort = cubit.state.productsSort;

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewPadding.bottom,
        ),
        child: _ProductSortSheet(
          selectedSort: currentSort,
          onSelected: (sort) {
            Navigator.pop(sheetContext);
            cubit.changeProductSort(sort);
            onSortSelected?.call();
          },
        ),
      );
    },
  );
}

class ProductSortFilterButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const ProductSortFilterButton({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final accent = context.mainColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            gradient: isActive ? AppColors.linearLight : null,
            color: isActive
                ? null
                : (isDark
                    ? Colors.white.withOpacity(0.06)
                    : AppColors.lightGrey),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : (isDark ? Colors.white12 : AppColors.whiteGrey),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.tune_rounded,
                size: 16.sp,
                color: isActive ? AppColors.white : accent,
              ),
              SizedBox(width: 4.w),
              Text(
                'Sort',
                style: GoogleFonts.outfit(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? AppColors.white
                      : (isDark ? AppColors.white : AppColors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductSortSheet extends StatelessWidget {
  final String? selectedSort;
  final ValueChanged<String> onSelected;

  const _ProductSortSheet({
    required this.selectedSort,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final subtitleColor = isDark ? Colors.white54 : AppColors.grey;
    final sheetBg = isDark ? const Color(0xFF121212) : AppColors.white;

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      decoration: BoxDecoration(
        color: sheetBg,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.45 : 0.12),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.35),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    gradient: AppColors.linearLight,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.sort_rounded,
                    color: AppColors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sort Products',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          color: textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Choose how products are ordered',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          color: subtitleColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ProductSortOption.values.map((option) {
                final isSelected = selectedSort == option.apiValue;
                return _SortOptionTile(
                  option: option,
                  isSelected: isSelected,
                  isDark: isDark,
                  onTap: () => onSelected(option.apiValue),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _SortOptionTile extends StatelessWidget {
  final ProductSortOption option;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _SortOptionTile({
    required this.option,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppColors.white : AppColors.black;
    final subtitleColor = isDark ? Colors.white54 : AppColors.grey;
    final accent = context.mainColor;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? accent.withOpacity(isDark ? 0.18 : 0.08)
                  : (isDark
                      ? Colors.white.withOpacity(0.04)
                      : AppColors.lightGrey.withOpacity(0.6)),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected
                    ? accent.withOpacity(0.5)
                    : (isDark ? Colors.white10 : AppColors.whiteGrey),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.linearLight : null,
                    color: isSelected
                        ? null
                        : (isDark
                            ? Colors.white.withOpacity(0.06)
                            : AppColors.white),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    option.icon,
                    size: 20.sp,
                    color: isSelected ? AppColors.white : accent,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${option.label} · ${option.subtitle}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSelected ? AppColors.linearLight : null,
                    border: Border.all(
                      color: isSelected ? Colors.transparent : subtitleColor,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          size: 14.sp,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
