import 'package:flutter/material.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';

extension ThemeExtensionX on BuildContext {
  Color get mainColor => isDarkMode
      ? AppColors.mainDarkColor.withOpacity(0.9)
      : AppColors.mainColor;
  Color get greyOrWhite => isDarkMode ? AppColors.white : AppColors.grey;
}
