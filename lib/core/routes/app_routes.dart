import 'package:flutter/material.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/presentation/splash/splash_screen.dart';

import '../../presentation/authentication/login/view/login_screen.dart';
import '../../presentation/onBoarding/view/on_boarding_view.dart';

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
