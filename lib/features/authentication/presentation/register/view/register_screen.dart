import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/authentication/presentation/register/bloc/register_bloc.dart';
import 'package:tradehub/features/authentication/presentation/register/view/widgets/register_view_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => getIt<RegisterBloc>(),
        child: const RegisterViewBody(),
      ),
    );
  }
}
