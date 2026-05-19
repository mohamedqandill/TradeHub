import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/checkout/data/models/request/checkout_request_d_t_o.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/checkout/presentation/payment_webview_screen.dart';
import 'package:tradehub/features/order_details/presentation/cubit/order_details_cubit.dart';
import 'package:tradehub/features/order_details/presentation/cubit/order_details_state.dart';
import 'package:tradehub/features/order_details/presentation/order_details_args.dart';
import 'package:tradehub/features/order_details/presentation/widgets/order_details_body.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrderDetailsArgs;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<OrderDetailsCubit>()..getOrderDetails(args.orderId),
        ),
        BlocProvider(
          create: (context) => getIt<CheckoutCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: MainLayoutAppBar(
          title: LocaleKeys.orderDetails.tr(),
          enableLeading: true,
        ),
        body: OrderDetailsBody(args: args),
        bottomNavigationBar: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, detailsState) {
            if (detailsState is GetOrderDetailsSuccess) {
              final order = detailsState.orderDetails;
              final bool isAwaitingPayment =
                  order.orderStatus == "AwaitingPayment";

              if (isAwaitingPayment) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                  child: BlocConsumer<CheckoutCubit, CheckoutState>(
                    listener: (context, checkoutState) {
                      if (checkoutState is PaymentWebhookSuccess) {
                        showSuccessSnackBar(
                            messageTitle: "Payment Successful!");
                        // Refresh order details immediately
                        context
                            .read<OrderDetailsCubit>()
                            .getOrderDetails(order.id);
                        // Refresh orders screen list using static instance
                        OrdersCubit.instance?.getOrders();
                      } else if (checkoutState is PaymentWebhookError) {
                        showFailureSnackBar(context,
                            messageTitle: checkoutState.error.message);
                      } else if (checkoutState is CheckoutSuccess) {
                        if (checkoutState.response.paymentUrl != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentWebViewScreen(
                                url: checkoutState.response.paymentUrl!,
                                cubit: context.read<CheckoutCubit>(),
                              ),
                            ),
                          );
                        } else {
                          showFailureSnackBar(context,
                              messageTitle: "Payment URL not found.");
                        }
                      } else if (checkoutState is CheckoutError) {
                        showFailureSnackBar(context,
                            messageTitle: checkoutState.error.message);
                      }
                    },
                    builder: (context, checkoutState) {
                      return CustomLargeMainButton(
                        text: "Complete Payment",
                        radius: 25.r,
                        isLoading: checkoutState is CheckoutLoading ||
                            checkoutState is PaymentWebhookLoading,
                        textStyle: context.base.theme.textTheme.titleLarge!
                            .copyWith(color: AppColors.white, fontSize: 16.sp),
                        onPressed: () {
                          final body = CheckoutRequestDTO(
                            basketId: order.id,
                            deliveryFee: order.deliveryFee.toInt(),
                            address: order.address,
                          );
                          context.read<CheckoutCubit>().checkout(body: body);
                        },
                      );
                    },
                  ),
                );
              }
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
