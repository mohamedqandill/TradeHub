import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/custom_checkout_card.dart';

import 'checkout_screen_body.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainLayoutAppBar(
          title: LocaleKeys.checkout.tr(),
          enableLeading: true,
        ),
        body: const CheckoutScreenBody(),
        bottomNavigationBar: const CustomCheckoutCard(
          isProceedButton: false,
        ));
  }
}
