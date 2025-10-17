import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/local_keys/local_keys.dart';
import 'package:tradehub/core/shared_widgets/auth_app_bar.dart';

import '../widgets/verify_email_view_body.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAuthAppBar(
        title: LocalKeys.verifyEmail.tr(),
      ),
      body: const VerifyEmailViewBody(),
    );
  }
}
