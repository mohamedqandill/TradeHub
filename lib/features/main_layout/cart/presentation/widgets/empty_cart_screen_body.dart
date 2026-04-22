import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';

class EmptyCartScreenBody extends StatelessWidget {
  const EmptyCartScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 43.h,
        ),
        Center(
          child: Image.asset(Assets.images.emptyCart.path),
        ),
        SizedBox(
          height: 18.h,
        ),
        Text(
          LocaleKeys.yourCartIsEmpty.tr(),
          style: context.base.theme.textTheme.titleLarge
              ?.copyWith(color: context.mainColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 18.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            textAlign: TextAlign.center,
            LocaleKeys.timeToFillItUpAndExplore.tr(),
            style: context.base.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400, color: context.greyOrWhite),
          ),
        ),
        SizedBox(
          height: 46.h,
        ),
        CustomLargeMainButton(
            textStyle: context.base.theme.textTheme.titleLarge!
                .copyWith(fontSize: 18.sp, color: Colors.white),
            onPressed: () {},
            radius: 50.r,
            height: 56.h,
            text: LocaleKeys.startShopping.tr())
      ],
    );
  }
}
