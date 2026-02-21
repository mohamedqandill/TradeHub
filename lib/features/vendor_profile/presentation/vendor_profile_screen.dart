import 'package:flutter/material.dart';
import 'package:tradehub/features/vendor_profile/presentation/vendor_profile_screen_body.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VendorProfileScreenBody(),
    );
  }
}
