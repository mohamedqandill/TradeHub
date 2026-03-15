import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

class OrderStatusTimelineSection extends StatelessWidget {
  const OrderStatusTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    int currentStep = 5; // 5 steps for delivered
    List<String> steps = [
      LocaleKeys.orderPlaced.tr(),
      LocaleKeys.orderConfirmed.tr(),
      LocaleKeys.orderShipped.tr(),
      LocaleKeys.outForDelivery.tr(),
      LocaleKeys.orderDelivered.tr(),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isEven) {
            int stepIndex = index ~/ 2;
            bool isCompleted = stepIndex < currentStep;

            return Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted ? context.mainColor : Colors.grey[300],
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    steps[stepIndex],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: context.base.theme.textTheme.labelSmall?.copyWith(
                      color: isCompleted ? context.mainColor : AppColors.grey,
                      fontWeight:
                          isCompleted ? FontWeight.bold : FontWeight.w600,
                      fontSize: 11.sp,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            );
          } else {
            int lineIndex = (index - 1) ~/ 2;
            bool isLineCompleted = lineIndex < (currentStep - 1);
            return Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 13.w),
                height: 2.h,
                color: isLineCompleted
                    ? context.mainColor
                    : Colors.grey.withOpacity(0.3),
              ),
            );
          }
        }),
      ),
    );
  }
}
