import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.labelText,
      this.autoFillHints = "",
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.isFocused});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String autoFillHints;
  final Function(bool isFocused)? isFocused;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode searchFocused;

  @override
  void initState() {
    searchFocused = FocusNode();

    searchFocused.addListener(
      () {
        if (searchFocused.hasFocus) {
          print("Search field is focused (opened/tapped)");
          widget.isFocused?.call(true);
        } else {
          print("Search field lost focus (closed/unfocused)");
          widget.isFocused?.call(false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335.w,
      child: TextFormField(
        focusNode: searchFocused,
        onTapOutside: (event) {
          searchFocused.unfocus();
          widget.isFocused?.call(false);
        },
        autofillHints: [widget.autoFillHints],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: Theme.of(context).textTheme.labelSmall,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            isDense: true,
            labelText: widget.labelText,
            prefixIcon: widget.prefixIcon,
            errorStyle: context.base.theme.textTheme.bodySmall!
                .copyWith(color: Colors.red),
            hintText: widget.hintText,
            suffixIconColor:
                context.isDarkMode ? AppColors.white : AppColors.grey,
            suffixIcon: widget.suffixIcon),
      ),
    );
  }
}
