import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';

import 'checkout_screen_body.dart';

import 'package:tradehub/features/order_details/presentation/order_details_args.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: LocaleKeys.checkout.tr(),
        enableLeading: true,
      ),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          final cubit = context.read<CheckoutCubit>();
          if (state is PaymentWebhookSuccess) {
            showSuccessSnackBar(messageTitle: "Payment Successful!");

            // 1. Refresh Cart (Remove checked out items)
            context.read<CartCubit>().resetCart();

            // 2. Navigate to Order Details
            Navigator.pushNamed(
              context,
              Routes.orderDetails,
              arguments: OrderDetailsArgs(
                orderId: cubit.checkoutResponse?.orderId ?? 0,
                items: cubit.items?.items ?? [],
                address: cubit.address ?? "Address not specified",
                status: "Processing",
                subTotal: cubit.items?.subTotal ?? 0,
              ),
            );
          } else if (state is PaymentWebhookError) {
            showFailureSnackBar(context, messageTitle: state.error.message);
          }
        },
        child: const CheckoutScreenBody(),
      ),
    );
  }
}
