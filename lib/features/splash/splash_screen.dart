import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/app_assets.dart';
import 'package:tradehub/core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, Routes.onBoarding);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Spacer(),
          AnimatedScale(
            scale: _opacity,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: SvgPicture.asset(context.isDarkMode
                  ? AppAssets.darkSplash
                  : AppAssets.splashLogo),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              fit: BoxFit.fill,
              context.isDarkMode ? AppAssets.bottomDarkWave : AppAssets.wave,
            ),
          )
        ],
      ),
    );
  }
}
