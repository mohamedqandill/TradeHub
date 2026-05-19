import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

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
    bool isDarkMode = context.isDarkMode;

    return Container(
      height: 60.h,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final catIndex = index;
          final isSelected = selectedIndex == catIndex;

          Color pillBgColor;
          Color borderColor;
          Color textColor;

          if (isSelected) {
            pillBgColor = context.mainColor;
            borderColor = Colors.transparent;
            textColor = Colors.white;
          } else {
            pillBgColor = isDarkMode ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03);
            borderColor = isDarkMode ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06);
            textColor = isDarkMode ? Colors.white70 : Colors.black54;
          }

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = catIndex);
              widget.onCategorySelected?.call(catIndex);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: pillBgColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: borderColor,
                  width: 1.1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: context.mainColor.withOpacity(0.24),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : null,
              ),
              child: Text(
                widget.categories[catIndex],
                style: GoogleFonts.outfit(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  fontSize: 13.sp,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
