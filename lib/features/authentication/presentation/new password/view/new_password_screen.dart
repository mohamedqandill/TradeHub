import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/shared_widgets/auth_app_bar.dart';
import 'package:tradehub/features/authentication/presentation/new%20password/view/widgets/new_password_view_body.dart';

import '../../../../../core/localization/locale_keys.g.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAuthAppBar(title: LocaleKeys.createNewPassword.tr()),
      body: const NewPasswordViewBody(),
    );
  }
}
