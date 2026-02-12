import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/onBoarding/view_model/language_view_model.dart';

import '../../features/onBoarding/view_model/theme_view_model.dart';

extension IsDarkMode on BuildContext {
  bool get isDarkMode => read<ThemeViewModel>().mode == ThemeMode.dark;
  bool get isArabic => getIt<LanguageViewModel>().isArabic;
}
