import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/onBoarding/view_model/theme_view_model.dart';

extension IsDarkMode on BuildContext {
  bool get isDarkMode => read<ThemeViewModel>().mode == ThemeMode.dark;
}
