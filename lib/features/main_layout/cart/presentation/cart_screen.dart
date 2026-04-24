import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';

import 'package:tradehub/main.dart';
import 'cart_screen_body.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/di/di.dart';
import 'cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(title: LocaleKeys.myCart.tr()),
      body: const CartScreenBody(),
    );
  }
}
