import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../colors/app_colors.dart';

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
    this.showArrow,
    this.suffixIcon,
  });

  final String text;
  final bool? showArrow;
  final TextStyle? textStyle;
  final bool isLoading;
  final double? width, height, radius;
  final void Function()? onPressed;
  final Widget? suffixIcon;

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
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: context.mainColor,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            style: textStyle ??
                                context.base.theme.textTheme.titleLarge!
                                    .copyWith(color: AppColors.white),
                          ),
                          if (showArrow == true && suffixIcon == null)
                            Padding(
                              padding:
                                  context.locale.languageCode == AppConstants.en
                                      ? EdgeInsets.only(left: 5.w)
                                      : EdgeInsets.only(right: 5.w),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 25.sp,
                                color: Colors.white,
                              ),
                            )
                          else if (suffixIcon != null)
                            suffixIcon!
                          else
                            const SizedBox(),
                        ],
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
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: textStyle ??
                            context.base.theme.textTheme.titleLarge!
                                .copyWith(color: AppColors.white),
                      ),
                      if (showArrow == true && suffixIcon == null)
                        Padding(
                          padding:
                              context.locale.languageCode == AppConstants.en
                                  ? EdgeInsets.only(left: 5.w)
                                  : EdgeInsets.only(right: 5.w),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 22.sp,
                            color: Colors.white,
                          ),
                        )
                      else if (suffixIcon != null)
                        suffixIcon!
                      else
                        const SizedBox(),
                    ],
                  ));
  }
}
