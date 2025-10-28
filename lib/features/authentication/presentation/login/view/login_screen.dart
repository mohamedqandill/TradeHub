import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/authentication/presentation/login/bloc/login_bloc.dart';
import 'package:tradehub/features/authentication/presentation/login/view/widgets/login_view_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: const LoginViewBody(),
      ),
    );
  }
}
