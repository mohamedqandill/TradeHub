import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/features/onBoarding/view/widgets/on_boarding_view_body.dart';

import '../../../core/constants/app_constants.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingViewBody(
        isArabic: context.locale.languageCode == AppConstants.ar,
      ),
    );
  }
}
