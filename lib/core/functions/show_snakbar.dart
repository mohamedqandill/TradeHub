import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';

void showSuccessSnackBar(BuildContext context,
    {required String messageTitle, String? title}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    AnimatedSnackBar(
      builder: (context) {
        return MaterialAnimatedSnackBar(
          messageText: messageTitle,
          type: AnimatedSnackBarType.success,
          messageTextStyle: context.base.theme.textTheme.bodyMedium
              ?.copyWith(color: AppColors.white),
        );
      },
    ).show(context);
  });
}

void showFailureSnackBar(BuildContext context, {required String messageTitle}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    AnimatedSnackBar(
      builder: (context) {
        return MaterialAnimatedSnackBar(
          messageText: messageTitle,
          type: AnimatedSnackBarType.error,
          messageTextStyle: context.base.theme.textTheme.bodyMedium
              ?.copyWith(color: AppColors.white),
        );
      },
    ).show(context);
  });
}
