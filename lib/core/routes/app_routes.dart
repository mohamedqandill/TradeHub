import 'package:flutter/material.dart';
import 'package:tradehub/core/extensions/screen_route_transition.dart';
import 'package:tradehub/core/routes/routes.dart';

import '../../features/authentication/presentation/forget password/view/forget_password_screen.dart';
import '../../features/authentication/presentation/login/view/login_screen.dart';
import '../../features/authentication/presentation/new password/view/new_password_screen.dart';
import '../../features/authentication/presentation/register/view/register_screen.dart';
import '../../features/authentication/presentation/verify email/view/verify_email_screen.dart';
import '../../features/onBoarding/view/on_boarding_view.dart';
import '../../features/splash/splash_screen.dart';

abstract class AppRoutes {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      // OnBoarding → SlideRight
      case Routes.onBoarding:
        return const OnBoardingView().customRoute(
          settings: settings,
          type: TransitionType.slideRight,
        );

      // Splash → Fade
      case Routes.splash:
        return const SplashScreen().customRoute(
          settings: settings,
          type: TransitionType.fade,
        );

      // Login → Fade
      case Routes.login:
        return const LoginScreen().customRoute(
          settings: settings,
          type: TransitionType.fade,
        );

      // Register → SlideLeft
      case Routes.signUp:
        return const RegisterScreen().customRoute(
          settings: settings,
          type: TransitionType.slideLeft,
        );

      // Forget Password → Fade
      case Routes.forgetPassword:
        return const ForgetPasswordScreen().customRoute(
          settings: settings,
          type: TransitionType.fade,
        );

      // Verify Email → SlideUp
      case Routes.verifyEmail:
        return const VerifyEmailScreen().customRoute(
          settings: settings,
          type: TransitionType.fade,
        );

      // New Password → SlideUp
      case Routes.newPassword:
        return const NewPasswordScreen().customRoute(
          settings: settings,
          type: TransitionType.fade,
        );

      // Default → Undefined
      default:
        return MaterialPageRoute(
          builder: (context) => const UnDefined(),
        );
    }
  }
}

class UnDefined extends StatelessWidget {
  const UnDefined({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Route Not Defined")),
    );
  }
}
