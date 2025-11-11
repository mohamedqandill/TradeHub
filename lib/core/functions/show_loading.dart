import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.mainColor,
          color: AppColors.white,
        ),
      );
    },
  );
}

hideDialog(BuildContext context) {
  Navigator.pop(context);
}
