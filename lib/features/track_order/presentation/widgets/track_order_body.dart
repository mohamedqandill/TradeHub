import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

class TrackOrderBody extends StatelessWidget {
  const TrackOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${LocaleKeys.orderId.tr()} #8829-XPL",
                style: context.base.theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                LocaleKeys.expectedDate.tr(),
                style: context.base.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              Text(
                "Oct 24, 2026",
                style: context.base.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.grey,
                ),
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: _buildTimeline(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 100.h),
      children: [
        _buildTimelineStep(
          context,
          time: "TODAY, 2:45 PM",
          title: LocaleKeys.outForDelivery.tr(),
          description: LocaleKeys.yourCourierIsMinutesAway.tr(),
          icon: Icons.local_shipping,
          isActive: true,
        ),
        _buildTimelineStep(
          context,
          time: "TODAY, 11:20 AM",
          title: LocaleKeys.arrivedAtSortingFacility.tr(),
          description: LocaleKeys.northLondonDistributionHub.tr(),
          icon: Icons.hub_outlined,
          isActive: false,
        ),
        _buildTimelineStep(
          context,
          time: "TODAY, 08:15 AM",
          title: LocaleKeys.leftWarehouse.tr(),
          description: LocaleKeys.packageProcessedAndDispatched.tr(),
          icon: Icons.inventory_2_outlined,
          isActive: false,
        ),
        _buildTimelineStep(
          context,
          time: "YESTERDAY, 9:30 PM",
          title: LocaleKeys.orderConfirmed.tr(),
          description: LocaleKeys.paymentSuccessfullyVerified.tr(),
          icon: Icons.check_circle_outline,
          isActive: false,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineStep(
    BuildContext context, {
    required String time,
    required String title,
    required String description,
    required IconData icon,
    bool isActive = false,
    bool isLast = false,
  }) {
    bool isDarkMode = context.isDarkMode;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    Color itemColor = isActive ? context.mainColor : AppColors.grey;
    Color iconBgColor = isActive
        ? context.mainColor
        : (isDarkMode ? AppColors.black : Colors.white);
    Color iconColor = isActive ? Colors.white : context.mainColor;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBgColor,
                  border: Border.all(
                    color: itemColor,
                    width: 1.5,
                  ),
                ),
                child: Icon(icon, color: iconColor, size: 16.sp),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: AppColors.grey.withOpacity(0.3),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: context.base.theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    title,
                    style: context.base.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isActive ? textColor : itemColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: context.base.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
