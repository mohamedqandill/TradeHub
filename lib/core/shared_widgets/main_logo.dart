import 'package:flutter/material.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/Core/shared_widgets/svg_widget.dart';
import 'package:tradehub/core/assets/app_assets.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgWidget(
      assetName:
          context.isDarkMode ? AppAssets.mainDarkLogo : AppAssets.mainLogo,
    );
  }
}
