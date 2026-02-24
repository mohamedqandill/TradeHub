import 'package:flutter/material.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/app_assets.dart';

class MainTopWave extends StatelessWidget {
  const MainTopWave({super.key, required this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        width: double.infinity,
        fit: BoxFit.fill,
        height: height,
        context.isDarkMode ? AppAssets.topDarkWave : AppAssets.topWave);
  }
}
