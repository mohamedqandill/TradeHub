import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/shared_widgets/app_bars/auth_app_bar.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/authentication/presentation/forget%20password/bloc/forget_password_bloc.dart';
import 'package:tradehub/features/authentication/presentation/forget%20password/view/widgets/forget_pass_view_body.dart';

import '../../../../../core/localization/locale_keys.g.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordBloc>(),
      child: Scaffold(
        appBar: buildAuthAppBar(
          title: LocaleKeys.forgetPass.tr(),
        ),
        body: const ForgetPassViewBody(),
      ),
    );
  }
}
