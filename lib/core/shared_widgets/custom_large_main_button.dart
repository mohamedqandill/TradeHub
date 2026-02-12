import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

import '../colors/app_colors.dart';

class CustomLargeMainButton extends StatelessWidget {
  const CustomLargeMainButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.textStyle,
    this.radius,
    this.isLoading = false,
    this.onPressed,
  });

  final String text;
  final TextStyle? textStyle;
  final bool isLoading;
  final double? width, height, radius;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return context.isDarkMode
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 12.r),
                gradient: AppColors.linearDarkColor),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(radius ?? 12.r)))),
                  fixedSize: WidgetStatePropertyAll(
                      Size(width ?? 335.w, height ?? 48.h)),
                ),
                onPressed: onPressed,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        text,
                        style: textStyle ??
                            context.base.theme.textTheme.titleLarge!
                                .copyWith(color: AppColors.white),
                      )),
          )
        : ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12.r)))),
              fixedSize:
                  WidgetStatePropertyAll(Size(width ?? 335.w, height ?? 48.h)),
            ),
            onPressed: onPressed,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    text,
                    style: context.base.theme.textTheme.titleLarge!
                        .copyWith(color: AppColors.white),
                  ));
  }
}
