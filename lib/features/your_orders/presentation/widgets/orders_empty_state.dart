import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/your_orders/domain/entities/order_status_filter.dart';

class OrdersEmptyState extends StatelessWidget {
  final OrderStatusFilter status;

  const OrdersEmptyState({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final subtitleColor = isDark ? Colors.white54 : AppColors.grey;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/emptyOrders.json',
              width: 180.w,
              height: 180.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16.h),
            Text(
              'Nothing here yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              status.emptyMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: subtitleColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
