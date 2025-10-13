import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base/base_inherited_widgets.dart';
import '../colors/app_colors.dart';

class CustomMainButton extends StatelessWidget {
  const CustomMainButton(
      {super.key,
      required this.text,
      this.width,
      this.height,
      this.radius,
      this.onPressed});

  final String text;
  final double? width, height, radius;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final base = BaseInheritedWidget.of(context);

    return ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(radius ?? 12.r)))),
            fixedSize:
                WidgetStatePropertyAll(Size(width ?? 160.w, height ?? 48.h)),
            backgroundColor: const WidgetStatePropertyAll(AppColors.mainColor)),
        onPressed: onPressed,
        child: Text(
          text,
          style:
              base.theme.textTheme.titleLarge!.copyWith(color: AppColors.white),
        ));
  }
}
