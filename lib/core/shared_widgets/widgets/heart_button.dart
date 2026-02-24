import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

import '../../assets/assets.gen.dart';

class HeartButton extends StatefulWidget {
  const HeartButton({super.key});

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool isHeartTapped = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isHeartTapped = !isHeartTapped;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SvgWidget(
          assetName: isHeartTapped
              ? Assets.icons.favouriteFilled
              : Assets.icons.favourite,
          width: 38.w,
          height: 38.h,
          fit: BoxFit.cover,
          color: isHeartTapped
              ? Colors.red
              : context.isDarkMode
                  ? AppColors.white
                  : Colors.grey,
        ),
      ),
    );
  }
}
