import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradehub/core/assets/app_assets.dart';

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
            duration: const Duration(seconds: 2),
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: _opacity,
              child: SvgPicture.asset(AppAssets.splashLogo),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              fit: BoxFit.fill,
              AppAssets.wave,
            ),
          )
        ],
      ),
    );
  }
}
