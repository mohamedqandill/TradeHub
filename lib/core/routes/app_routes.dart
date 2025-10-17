import 'package:flutter/material.dart';
import 'package:tradehub/core/routes/routes.dart';

import '../../features//onBoarding/view/on_boarding_view.dart';
import '../../features/authentication/presentation/forget password/view/forget_password_screen.dart';
import '../../features/authentication/presentation/login/view/login_screen.dart';
import '../../features/authentication/presentation/new password/view/new_password_screen.dart';
import '../../features/authentication/presentation/register/view/register_screen.dart';
import '../../features/authentication/presentation/verify email/view/verify_email_screen.dart';
import '../../features/splash/splash_screen.dart';

abstract class AppRoutes {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );
      case Routes.verifyEmail:
        return MaterialPageRoute(
          builder: (context) => const VerifyEmailScreen(),
        );
      case Routes.newPassword:
        return MaterialPageRoute(
          builder: (context) => const NewPasswordScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const UnDefined(),
        );
      // case Routes.login:
      //   return MaterialPageRoute(builder: (context) => ,);
      // case Routes.signUp:
      //   return MaterialPageRoute(builder: (context) => ,);
      // case Routes.successfulNewPassword:
      //   return MaterialPageRoute(builder: (context) => ,);
      // case Routes.verifyEmail:
      //   return MaterialPageRoute(builder: (context) => ,);
      // case Routes.forgetPassword:
      //   return MaterialPageRoute(builder: (context) => ,);
    }
  }
}

class UnDefined extends StatelessWidget {
  const UnDefined({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
