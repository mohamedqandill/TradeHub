import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/colors/app_colors.dart';

class VendorCategoryPills extends StatefulWidget {
  final List<String> categories;
  final Function(int index)? onCategorySelected;
  const VendorCategoryPills({super.key, required this.categories, this.onCategorySelected});

  @override
  State<VendorCategoryPills> createState() => _VendorCategoryPillsState();
}

class _VendorCategoryPillsState extends State<VendorCategoryPills> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final catIndex = index;
          final isSelected = selectedIndex == catIndex;
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = catIndex);
              widget.onCategorySelected?.call(catIndex);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? context.mainColor : Colors.transparent,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppColors.grey.withOpacity(0.3),
                ),
              ),
              child: Text(
                widget.categories[catIndex],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.grey,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
