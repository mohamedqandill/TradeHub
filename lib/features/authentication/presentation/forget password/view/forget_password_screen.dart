import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/localization/local_keys/local_keys.dart';
import '../../../../../Core/shared_widgets/auth_app_bar.dart';
import '../widgets/forget_pass_view_body.dart';

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
