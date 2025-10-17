import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335.w,
      height: 48.h,
      child: TextFormField(
        style: Theme.of(context).textTheme.labelSmall,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon,
            hintText: hintText,
            suffixIconColor:
                context.isDarkMode ? AppColors.white : AppColors.grey,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
