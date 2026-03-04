import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  int _selectedMethod = 0; // 0 for Card, 1 for Wallet

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.paymentMethod.tr(),
          style: context.base.theme.textTheme.titleLarge?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 16.h),
        _buildPaymentCard(
          context: context,
          index: 0,
          title: LocaleKeys.payWithCard.tr(),
          subtitle: LocaleKeys.visaMastercardAmex.tr(),
          icon: Icons.credit_card,
        ),
        SizedBox(height: 12.h),
        _buildPaymentCard(
          context: context,
          index: 1,
          title: LocaleKeys.digitalWallets.tr(),
          subtitle: LocaleKeys.applePayGooglePay.tr(),
          icon: Icons.account_balance_wallet_outlined,
        ),
      ],
    );
  }

  Widget _buildPaymentCard({
    required BuildContext context,
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    bool isSelected = _selectedMethod == index;
    bool isDarkMode = context.isDarkMode;
    Color cardColor =
        isDarkMode ? AppColors.black.withOpacity(0.3) : AppColors.white;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;
    Color borderColor =
        isSelected ? context.mainColor : context.greyOrWhite.withOpacity(0.1);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 48.w,
              width: 48.w,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey[800]
                    : AppColors.lightGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(icon,
                    color: isDarkMode
                        ? AppColors.white
                        : AppColors.lightBlack.withOpacity(0.7),
                    size: 24.sp),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.base.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: context.base.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 22.w,
              width: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? context.mainColor
                      : AppColors.grey.withOpacity(0.3),
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
