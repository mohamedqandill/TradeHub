import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/shared_widgets/auth_app_bar.dart';
import 'package:tradehub/features/authentication/presentation/forget%20password/bloc/forget_password_bloc.dart';
import 'package:tradehub/features/authentication/presentation/verify%20email/view/widgets/verify_email_view_body.dart';

import '../../../../../core/localization/locale_keys.g.dart';
import '../../../../../core/utils/di/di.dart';
import '../bloc/verify_otp_bloc.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<VerifyOtpBloc>()..getEmail(email: email),
        ),
        BlocProvider(create: (context) => getIt<ForgetPasswordBloc>()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAuthAppBar(
          title: LocaleKeys.verifyEmail.tr(),
        ),
        body: const VerifyEmailViewBody(),
      ),
    );
  }
}
