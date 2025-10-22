import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/features/authentication/presentation/forget%20password/view/widgets/forget_pass_view_body.dart';

import '../../../../../Core/shared_widgets/auth_app_bar.dart';
import '../../../../../core/localization/locale_keys.g.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAuthAppBar(
        title: LocaleKeys.forgetPass.tr(),
      ),
      body: const ForgetPassViewBody(),
    );
  }
}
