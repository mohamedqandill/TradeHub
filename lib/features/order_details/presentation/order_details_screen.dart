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
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/checkout/data/models/request/checkout_request_d_t_o.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/checkout/presentation/payment_webview_screen.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/order_details/presentation/cubit/order_details_cubit.dart';
import 'package:tradehub/features/order_details/presentation/cubit/order_details_state.dart';
import 'package:tradehub/features/order_details/presentation/order_details_args.dart';
import 'package:tradehub/features/order_details/presentation/widgets/order_details_body.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderDetailsArgs args;
  const OrderDetailsScreen({super.key, required this.args});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrderDetailsCubit _orderDetailsCubit = getIt<OrderDetailsCubit>();

  @override
  void initState() {
    super.initState();
    _orderDetailsCubit.getOrderDetails(widget.args.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _orderDetailsCubit,
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, detailsState) {
          if (detailsState is CancelOrderSuccess) {
            OrdersCubit.instance?.getOrders(isRefresh: true);
            context
                .read<OrderDetailsCubit>()
                .getOrderDetails(widget.args.orderId);
            showSuccessSnackBar(messageTitle: detailsState.message);
          } else if (detailsState is CancelOrderError) {
            showFailureSnackBar(context, messageTitle: detailsState.message);
          }
        },
        builder: (context, detailsState) => RefreshIndicator(
          onRefresh: () async {
            await context
                .read<OrderDetailsCubit>()
                .getOrderDetails(widget.args.orderId);
          },
          child: BlocListener<CheckoutCubit, CheckoutState>(
            listener: (context, state) {
              if (state is PaymentWebhookSuccess) {
                showSuccessSnackBar(messageTitle: "Payment Successful!");

                context.read<CartCubit>().isCartChanged = true;
                context.read<CartCubit>().getBasket();

                OrdersCubit.instance?.getOrders(isRefresh: true);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.orderDetails,
                  (route) => route.settings.name == Routes.mainLayout,
                  arguments: OrderDetailsArgs(
                    orderId: widget.args.orderId,
                  ),
                );
              } else if (state is PaymentWebhookError) {
                showFailureSnackBar(context, messageTitle: state.error.message);
              }
            },
            child: Scaffold(
              appBar: MainLayoutAppBar(
                title: LocaleKeys.orderDetails.tr(),
                enableLeading: true,
              ),
              body: OrderDetailsBody(args: widget.args),
              bottomNavigationBar:
                  BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                builder: (context, detailsState) {
                  if (detailsState is GetOrderDetailsSuccess) {
                    final order = detailsState.orderDetails;
                    final bool isAwaitingPayment =
                        order.orderStatus == "AwaitingPayment";

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 20.h,
                      ),
                      child: BlocConsumer<CheckoutCubit, CheckoutState>(
                        listener: (context, checkoutState) {},
                        builder: (context, checkoutState) {
                          return isAwaitingPayment
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: CustomLargeMainButton(
                                          text: "Cancel Order",
                                          radius: 25.r,
                                          isLoading: checkoutState
                                                  is CheckoutLoading ||
                                              checkoutState
                                                  is PaymentWebhookLoading,
                                          textStyle: context
                                              .base.theme.textTheme.titleLarge!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontSize: 12.sp),
                                          onPressed: () {
                                            context
                                                .read<OrderDetailsCubit>()
                                                .cancelOrder(
                                                    widget.args.orderId);
                                          }),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: CustomLargeMainButton(
                                        text: "Complete\n Payment",
                                        radius: 25.r,
                                        isLoading:
                                            checkoutState is CheckoutLoading ||
                                                checkoutState
                                                    is PaymentWebhookLoading,
                                        textStyle: context
                                            .base.theme.textTheme.titleLarge!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontSize: 12.sp),
                                        onPressed: () {
                                          final savedUrl = HiveStorageHelper()
                                              .getString(
                                                  "payment_url_order_${order.id}");
                                          if (savedUrl != null &&
                                              savedUrl.isNotEmpty) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentWebViewScreen(
                                                  url: savedUrl,
                                                  cubit: context
                                                      .read<CheckoutCubit>(),
                                                  orderId: widget.args.orderId,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox();
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
