import 'package:flutter/material.dart';

import '../../../../../../Core/colors/app_colors.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider(
      {super.key,
      this.indent,
      this.enIndent,
      this.thickness,
      this.opacity,
      this.isExpanded});
  final double? indent, enIndent, thickness, opacity;
  final bool? isExpanded;
  @override
  Widget build(BuildContext context) {
    return isExpanded != null
        ? Expanded(
            child: Divider(
              color: AppColors.grey.withOpacity(opacity ?? 0.5),
              thickness: thickness ?? 1,
              indent: indent,
              endIndent: enIndent,
            ),
          )
        : Divider(
            color: AppColors.grey.withOpacity(opacity ?? 0.5),
            thickness: thickness ?? 1,
            indent: indent,
            endIndent: enIndent,
          );
  }
}
