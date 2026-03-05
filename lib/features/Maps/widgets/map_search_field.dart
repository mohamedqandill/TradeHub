import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_category_widget.dart';

class MapSearchTextField extends StatefulWidget {
  const MapSearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isFocused,
  });

  final TextEditingController controller;
  final String hintText;
  final Function(bool) isFocused;

  @override
  State<MapSearchTextField> createState() => _MapSearchTextFieldState();
}

class _MapSearchTextFieldState extends State<MapSearchTextField> {
  late FocusNode searchFocused;

  @override
  void initState() {
    searchFocused = FocusNode();
    searchFocused.addListener(() {
      widget.isFocused(searchFocused.hasFocus);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchFocused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xff1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        focusNode: searchFocused,
        onTapOutside: (event) {
          searchFocused.unfocus();
        },
        controller: widget.controller,
        style: context.base.theme.textTheme.bodyMedium?.copyWith(
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: context.base.theme.textTheme.bodyMedium?.copyWith(
            color:
                context.isDarkMode ? Colors.grey[500] : const Color(0xff9DA4B4),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Icon(
              Icons.search,
              color: context.mainColor,
              size: 24.sp,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 40.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(color: context.mainColor, width: 1),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        ),
      ),
    );
  }
}
