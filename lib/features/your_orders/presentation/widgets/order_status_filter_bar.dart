import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/your_orders/domain/entities/order_status_filter.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';

class OrderStatusFilterBar extends StatelessWidget {
  const OrderStatusFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final accent = context.mainColor;

    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (prev, curr) => prev.selectedStatus != curr.selectedStatus,
      builder: (context, state) {
        return SizedBox(
          height: 44.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: OrderStatusFilter.values.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final filter = OrderStatusFilter.values[index];
              final isSelected = state.selectedStatus == filter;

              return _FilterChip(
                filter: filter,
                isSelected: isSelected,
                isDark: isDark,
                accent: accent,
                onTap: () {
                  context.read<OrdersCubit>().changeStatusFilter(filter);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final OrderStatusFilter filter;
  final bool isSelected;
  final bool isDark;
  final Color accent;
  final VoidCallback onTap;

  const _FilterChip({
    required this.filter,
    required this.isSelected,
    required this.isDark,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            gradient: isSelected ? AppColors.linearLight : null,
            color: isSelected
                ? null
                : (isDark
                    ? Colors.white.withOpacity(0.06)
                    : AppColors.lightGrey),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : (isDark ? Colors.white12 : AppColors.whiteGrey),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                filter.icon,
                size: 14.sp,
                color: isSelected
                    ? AppColors.white
                    : (isDark ? AppColors.white : accent),
              ),
              SizedBox(width: 6.w),
              Text(
                filter.shortLabel,
                style: GoogleFonts.outfit(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
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
