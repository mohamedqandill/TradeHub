import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/local_keys/local_keys.dart';
import 'package:tradehub/core/shared_widgets/auth_app_bar.dart';

import '../widgets/new_password_view_body.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAuthAppBar(title: LocalKeys.createNewPassword.tr()),
      body: const NewPasswordViewBody(),
    );
  }
}
