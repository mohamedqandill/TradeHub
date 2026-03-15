import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';

import 'widgets/track_order_body.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: LocaleKeys.trackTextOrder.tr(),
        enableLeading: true,
      ),
      body: const TrackOrderBody(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: CustomLargeMainButton(
          text: LocaleKeys.contactCourier.tr(),
          radius: 25.r,
          textStyle: context.base.theme.textTheme.titleLarge!
              .copyWith(color: AppColors.white, fontSize: 16.sp),
          onPressed: () {},
        ),
      ),
    );
  }
}
