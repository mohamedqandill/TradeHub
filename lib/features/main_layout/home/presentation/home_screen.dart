import 'package:flutter/material.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_app_bar.dart';

import 'home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(
        address: "Menoufia,Markaz Elbagour",
      ),
      body: HomeScreenBody(),
    );
  }
}
