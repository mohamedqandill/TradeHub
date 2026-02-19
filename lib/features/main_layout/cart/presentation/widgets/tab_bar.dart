import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../../../../Core/colors/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key, required this.tabs, required this.tabController});

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        labelStyle: context.base.theme.textTheme.bodyMedium!.copyWith(
          fontSize: 14.sp,
        ),
        splashFactory: NoSplash.splashFactory,
        controller: tabController,
        indicator: BoxDecoration(
          color: context.mainColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: context.isDarkMode ? AppColors.black : AppColors.white,
        unselectedLabelColor:
            context.isDarkMode ? AppColors.white : AppColors.black,
        unselectedLabelStyle:
            context.base.theme.textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
        dividerColor: Colors.transparent,
        tabs: tabs);
  }
}
