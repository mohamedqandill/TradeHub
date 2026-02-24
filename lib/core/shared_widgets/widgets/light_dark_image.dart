import 'package:flutter/material.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

class BuildLightDarkImage extends StatelessWidget {
  const BuildLightDarkImage(
      {super.key, required this.lightPath, required this.darkPath});
  final String lightPath;
  final String darkPath;

  @override
  Widget build(BuildContext context) {
    return context.isDarkMode ? Image.asset(darkPath) : Image.asset(lightPath);
  }
}
