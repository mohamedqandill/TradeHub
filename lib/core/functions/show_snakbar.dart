import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/main.dart';

void showSuccessSnackBar({required String messageTitle, String? title}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    AnimatedSnackBar(
      duration: const Duration(seconds: 2),
      // animationDuration: const Duration(seconds: 2),
      builder: (context) {
        return MaterialAnimatedSnackBar(
          messageText: messageTitle,
          type: AnimatedSnackBarType.success,
          messageTextStyle: context.base.theme.textTheme.bodyMedium
              ?.copyWith(color: AppColors.white),
        );
      },
    ).show(
      navigatorKey.currentContext!,
    );
  });
}

void showFailureSnackBar(BuildContext context, {required String messageTitle}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    AnimatedSnackBar(
      duration: const Duration(seconds: 2),
      // animationDuration: const Duration(seconds: 2),
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
