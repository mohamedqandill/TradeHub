import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class PaymentMethodStep extends StatelessWidget {
  final int selectedMethod; // 0 for Credit/Debit, 1 for COD
  final Function(int) onChanged;

  const PaymentMethodStep({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMethodCard(
          context: context,
          index: 0,
          title: "Credit/Debit Card",
          subtitle: "Visa, Mastercard, American Express",
          icon: Icons.credit_card_outlined,
        ),
      ],
    );
  }

  Widget _buildMethodCard({
    required BuildContext context,
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = selectedMethod == index;
    final isDark = context.isDarkMode;
    final primaryColor = context.mainColor;

    final cardColor = isDark
        ? (isSelected ? const Color(0xFF1E1E20) : const Color(0xFF121214))
        : (isSelected ? Colors.white : const Color(0xFFF9FAFB));

    final borderColor = isSelected
        ? primaryColor
        : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05));

    return GestureDetector(
      onTap: () => onChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 1.5.w : 1.w,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: primaryColor.withOpacity(isDark ? 0.2 : 0.04),
                blurRadius: 16.r,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.01),
                blurRadius: 8.r,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            // Outlined Icon Container
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withOpacity(0.08)
                    : (isDark ? Colors.white10 : const Color(0xFFF3F4F6)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: isSelected ? primaryColor : AppColors.grey,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Select Indicator (Radio Style)
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? primaryColor
                      : AppColors.grey.withOpacity(0.4),
                  width: isSelected ? 6.w : 1.5.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
