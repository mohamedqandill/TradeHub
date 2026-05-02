import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.nextFocusNode,
      this.focusedNode,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.labelText,
      this.autoFillHints = "",
      this.hintText,
      this.initialValue,
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
  final String? initialValue;
  final String autoFillHints;
  final Function(bool isFocused)? isFocused;
  final FocusNode? nextFocusNode;
  final FocusNode? focusedNode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode searchFocused;

  void _focusListener() {
    widget.isFocused?.call(searchFocused.hasFocus);
  }

  @override
  void initState() {
    super.initState();
    searchFocused = widget.focusedNode ?? FocusNode();
    searchFocused.addListener(_focusListener);
  }

  @override
  void dispose() {
    searchFocused.removeListener(_focusListener);
    if (widget.focusedNode == null) {
      searchFocused.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335.w,
      child: TextFormField(
        initialValue: widget.controller == null ? widget.initialValue : null,
        focusNode: searchFocused,
        onTapOutside: (_) {
          searchFocused.unfocus();
          widget.isFocused?.call(false);
        },
        textInputAction: widget.nextFocusNode != null 
            ? TextInputAction.next
            : TextInputAction.done,
        onFieldSubmitted: (_) {
          if (widget.nextFocusNode != null) {
            FocusScope.of(context).requestFocus(widget.nextFocusNode);
          } else {
            searchFocused.unfocus();
          }
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
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
