import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/custom_text_field.dart';

import '../../../../../Core/assets/app_assets.dart';
import '../../../../../Core/localization/local_keys/local_keys.dart';

class ForgetPassViewBody extends StatelessWidget {
  const ForgetPassViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48.h,
        ),
        Center(child: Image.asset(AppAssets.dataSecurity)),
        SizedBox(
          height: 27.h,
        ),
        Text(
          textAlign: TextAlign.center,
          LocalKeys.enterEmail.tr(),
          style: context.base.theme.textTheme.bodyMedium!.copyWith(
              color: context.isDarkMode ? AppColors.white : AppColors.grey),
        ),
        SizedBox(
          height: 34.h,
        ),
        CustomTextField(
          labelText: LocalKeys.emailAddress.tr(),
          suffixIcon: const Icon(Icons.email),
        ),
        SizedBox(
          height: 34.h,
        ),
        CustomLargeMainButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.verifyEmail);
          },
          text: LocalKeys.send.tr(),
        )
      ],
    );
  }
}
