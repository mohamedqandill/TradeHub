import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/features/main_layout/profile/presentation/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 profile build");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15.h,
      ),
      body: const ProfileScreenBody(),
    );
  }
}
