import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/presentation/authentication/forget%20password/widgets/forget_pass_view_body.dart';

import '../../../../core/localization/local_keys/local_keys.dart';
import '../../../../core/shared_widgets/auth_app_bar.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAuthAppBar(
        title: LocalKeys.forgetPass.tr(),
      ),
      body: const ForgetPassViewBody(),
    );
  }
}
