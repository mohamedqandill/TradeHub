import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

import '../../assets/assets.gen.dart';

class HeartButton extends StatefulWidget {
  const HeartButton({super.key, this.width, this.height, this.isTapped=false, this.onTap});
  final double? width;
  final double? height;
  final bool isTapped;
  final void Function( )?onTap;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SvgWidget(
          assetName: widget.isTapped
              ? Assets.icons.favouriteFilled
              : Assets.icons.favourite,
          width: widget.width ?? 38.w,
          height: widget.height ?? 38.h,
          fit: BoxFit.contain,
          color: widget.isTapped
              ? Colors.red
              : context.isDarkMode
                  ? AppColors.black
                  : Colors.grey,
        ),
      ),
    );
  }
}
