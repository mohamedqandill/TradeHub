import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/extensions/screen_route_transition.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/Maps/flutter_map_screen.dart';
import 'package:tradehub/features/category_details/presentation/category_details_screen.dart';
import 'package:tradehub/features/category_details/presentation/category_details_args.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/favourite_screen.dart';
import 'package:tradehub/features/main_layout/presentation/main_layout.dart';
import 'package:tradehub/features/about_app/presentation/about_app_screen.dart';
import 'package:tradehub/features/get_help/presentation/get_help_screen.dart';
import 'package:tradehub/features/product_details/presentation/product_details_screen.dart';
import 'package:tradehub/features/settings/presentation/settings_screen.dart';
import 'package:tradehub/features/settings/presentation/account_info/account_info_screen.dart';
import 'package:tradehub/features/your_orders/presentation/your_orders_screen.dart';
import 'package:tradehub/features/checkout/presentation/checkout_screen.dart';
import 'package:tradehub/features/order_details/presentation/order_details_screen.dart';
import 'package:tradehub/features/settings/presentation/saved_addresses/saved_addresses_screen.dart';
import 'package:tradehub/features/track_order/presentation/track_order_screen.dart';
import '../../features/authentication/presentation/forget password/view/forget_password_screen.dart';
import '../../features/authentication/presentation/login/view/login_screen.dart';
import '../../features/authentication/presentation/new password/view/new_password_screen.dart';
import '../../features/authentication/presentation/register/view/register_screen.dart';
import '../../features/authentication/presentation/verify email/view/verify_email_screen.dart';
import '../../features/onBoarding/view/on_boarding_view.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/vendor_profile/presentation/vendor_profile_screen.dart';

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
      case Routes.settings:
        return const SettingsScreen().customRoute(
          settings: settings,
          type: TransitionType.size,
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
      case Routes.vendorProfile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const VendorProfileScreen(),
        );
      case Routes.productDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ProductDetailsScreen(),
        );
      case Routes.categoryDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => CategoryDetailsScreen(
            args: settings.arguments as CategoryDetailsArgs,
          ),
        );

      // Forget Password → Fade
      case Routes.forgetPassword:
        return const ForgetPasswordScreen().customRoute(
          settings: settings,
          type: TransitionType.fade,
        );
      case Routes.mainLayout:
        return const MainLayout().customRoute(
          settings: settings,
          type: TransitionType.size,
        );

      case Routes.aboutApp:
        return const AboutAppScreen().customRoute(
          settings: settings,
          type: TransitionType.slideRight,
        );

      case Routes.getHelp:
        return const GetHelpScreen().customRoute(
          settings: settings,
          type: TransitionType.slideRight,
        );

      case Routes.yourOrders:
        return const YourOrdersScreen().customRoute(
          settings: settings,
          type: TransitionType.slideRight,
        );

      case Routes.accountInfo:
        return const AccountInfoScreen().customRoute(
          settings: settings,
          type: TransitionType.slideRight,
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

      case Routes.checkout:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              final cubit= settings.arguments as CheckoutCubit;
              return BlocProvider.value(
                value: cubit,
                child: const CheckoutScreen());
            });
      case Routes.flutterMap:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const FlutterMapScreen(),
        );
      case Routes.orderDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const OrderDetailsScreen(),
        );
      case Routes.trackOrder:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const TrackOrderScreen(),
        );
      case Routes.savedAddresses:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SavedAddressesScreen(),
        );
      case Routes.favourite:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const FavouriteScreen(),
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
