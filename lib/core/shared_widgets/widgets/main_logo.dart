import 'package:flutter/material.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/app_assets.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

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
