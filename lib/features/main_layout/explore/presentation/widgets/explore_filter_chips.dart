import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';

class ExploreFilterChips extends StatefulWidget {
  const ExploreFilterChips({super.key});

  @override
  State<ExploreFilterChips> createState() => _ExploreFilterChipsState();
}

class _ExploreFilterChipsState extends State<ExploreFilterChips> {
  final List<Map<String, dynamic>> filters = [
    {"label": "Rating", "icon": Icons.star_rounded},
    {"label": "Price", "icon": Icons.payments_rounded},
    {"label": "Distance", "icon": Icons.location_on_rounded},
    {"label": "Fast Delivery", "icon": Icons.bolt_rounded},
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = isSelected ? null : index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected 
                    ? context.mainColor 
                    : (context.isDarkMode ? AppColors.lightBlack : AppColors.lightGrey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppColors.grey.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    filters[index]["icon"],
                    size: 16.sp,
                    color: isSelected ? Colors.white : AppColors.grey,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    filters[index]["label"],
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.grey,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                  if (isSelected) ...[
                    SizedBox(width: 4.w),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 16.sp, color: Colors.white),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
