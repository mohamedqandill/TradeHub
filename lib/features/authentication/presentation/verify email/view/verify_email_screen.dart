import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/shared_widgets/auth_app_bar.dart';
import 'package:tradehub/features/authentication/presentation/verify%20email/view/widgets/verify_email_view_body.dart';

import '../../../../../core/localization/locale_keys.g.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAuthAppBar(
        title: LocaleKeys.verifyEmail.tr(),
      ),
      body: const VerifyEmailViewBody(),
    );
  }
}
