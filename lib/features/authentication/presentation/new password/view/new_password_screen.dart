import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/shared_widgets/app_bars/auth_app_bar.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/authentication/presentation/new%20password/bloc/new_password_bloc.dart';
import 'package:tradehub/features/authentication/presentation/new%20password/view/widgets/new_password_view_body.dart';
import 'package:tradehub/features/authentication/presentation/verify%20email/view/widgets/pin_put.dart';

import '../../../../../core/localization/locale_keys.g.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as UserEmailAndCode;
    return BlocProvider(
      create: (context) => getIt<NewPasswordBloc>()
        ..getEmailAndeCode(
            body: UserEmailAndCode(email: data.email, code: data.code)),
      child: Scaffold(
        appBar: buildAuthAppBar(title: LocaleKeys.createNewPassword.tr()),
        body: const NewPasswordViewBody(),
      ),
    );
  }
}
