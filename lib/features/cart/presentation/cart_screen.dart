import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/main_layout_app_bar.dart';
import 'package:tradehub/features/cart/presentation/widgets/empty_cart_screen_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(title: LocaleKeys.myCart.tr()),
      body: const EmptyCartScreenBody(),
    );
  }
}
