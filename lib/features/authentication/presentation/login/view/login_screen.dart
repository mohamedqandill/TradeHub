import 'package:flutter/material.dart';
import 'package:tradehub/features/authentication/presentation/login/view/widgets/login_view_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginViewBody(),
    );
  }
}
