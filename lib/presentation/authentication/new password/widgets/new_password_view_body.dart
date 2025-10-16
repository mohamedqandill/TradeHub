import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';

import '../../../../core/assets/app_assets.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/local_keys/local_keys.dart';
import '../../../../core/shared_widgets/custom_large_main_button.dart';
import '../../../../core/shared_widgets/custom_text_field.dart';

class NewPasswordViewBody extends StatelessWidget {
  const NewPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48.h,
        ),
        Center(child: Image.asset(AppAssets.strongPassword)),
        SizedBox(
          height: 27.h,
        ),
        Text(
          textAlign: TextAlign.center,
          LocalKeys.passwordMustBeDiff.tr(),
          style: context.base.theme.textTheme.bodyMedium!
              .copyWith(color: AppColors.grey),
        ),
        SizedBox(
          height: 34.h,
        ),
        CustomTextField(
          labelText: LocalKeys.newPassword.tr(),
          suffixIcon: const Icon(Icons.remove_red_eye),
        ),
        SizedBox(
          height: 34.h,
        ),
        CustomLargeMainButton(
          text: LocalKeys.save.tr(),
        )
      ],
    );
  }
}
