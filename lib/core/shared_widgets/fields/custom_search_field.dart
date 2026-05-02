import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField(
      {super.key,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.labelText,
      this.autoFillHints = "",
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.fillColor,
      this.borderColor,
      this.hintColor});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String autoFillHints;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        autofillHints: [autoFillHints],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: Theme.of(context).textTheme.labelSmall,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ??
                        (context.isDarkMode ? Colors.white : Colors.black),
                    width: 1),
                borderRadius: BorderRadius.circular(15.r)),
            fillColor: fillColor ?? AppColors.grey.withOpacity(0.05),
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ??
                        (context.isDarkMode
                            ? AppColors.mainDarkColor
                            : Colors.white),
                    width: 1),
                borderRadius: BorderRadius.circular(15.r)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ??
                        (context.isDarkMode
                            ? AppColors.mainDarkColor
                            : Colors.white),
                    width: 1),
                borderRadius: BorderRadius.circular(15.r)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ??
                        (context.isDarkMode
                            ? AppColors.mainDarkColor
                            : Colors.white),
                    width: 1),
                borderRadius: BorderRadius.circular(15.r)),
            hintStyle: context.base.theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: hintColor ??
                    (context.isDarkMode
                        ? Colors.white.withOpacity(0.7)
                        : AppColors.grey.withOpacity(0.4))),
            isDense: true,
            labelText: labelText,
            prefixIcon: prefixIcon,
            errorStyle: context.base.theme.textTheme.bodySmall!
                .copyWith(color: Colors.red),
            hintText: hintText,
            prefixIconColor: Colors.white,
            suffixIconColor:
                context.isDarkMode ? AppColors.white : AppColors.grey,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
