import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/widgets/heart_button.dart';
import 'package:tradehub/features/product_details/presentation/product_details_body.dart';

import '../../../core/shared_widgets/app_bars/main_layout_app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainLayoutAppBar(
        title: "loaded rice bowl",
        enableLeading: true,
        widgets: [HeartButton()],
      ),
      body: const ProductDetailsBody(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.sp),
        child: CustomLargeMainButton(
          text: LocaleKeys.addToCart.tr(),
          showArrow: true,
          textStyle: context.base.theme.textTheme.titleLarge!
              .copyWith(color: AppColors.white, fontSize: 22.sp),
        ),
      ),
    );
  }
}
