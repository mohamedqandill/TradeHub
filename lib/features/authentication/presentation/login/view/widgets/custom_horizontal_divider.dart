import 'package:flutter/material.dart';

import '../../../../../../Core/colors/app_colors.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider({super.key, this.indent, this.enIndent});
  final double? indent, enIndent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        color: AppColors.grey.withOpacity(0.5),
        thickness: 1,
        indent: indent,
        endIndent: enIndent,
      ),
    );
  }
}
