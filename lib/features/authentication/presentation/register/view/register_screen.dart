import 'package:flutter/material.dart';
import 'package:tradehub/features/authentication/presentation/register/view/widgets/register_view_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: RegisterViewBody(),
    );
  }
}
