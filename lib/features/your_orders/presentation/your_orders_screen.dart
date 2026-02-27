import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';

import 'widgets/your_orders_screen_body.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: tr(LocaleKeys.yourOrders),
        enableLeading: true,
      ),
      body: const YourOrdersScreenBody(),
    );
  }
}
