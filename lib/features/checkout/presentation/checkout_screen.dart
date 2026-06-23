import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';
import 'checkout_screen_body.dart';
import 'package:tradehub/features/order_details/presentation/order_details_args.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _hasCheckoutStarted = false;
  bool _paymentSuccess = false;

  Future<bool> _showAwaitingPaymentDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor:
            context.isDarkMode ? const Color(0xFF0F0F10) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: context.isDarkMode
                ? Colors.white10
                : Colors.black.withOpacity(0.05),
          ),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: context.mainColor, size: 24.sp),
            SizedBox(width: 10.w),
            Text(
              "Order Not Confirmed",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        content: Text(
          "Your order is not confirmed yet and is awaiting payment.",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: context.isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: Text(
              "Continue Payment",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.mainColor,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CartCubit>().isCartChanged = true;
              context.read<CartCubit>().getBasket();
              OrdersCubit.instance?.getOrders(isRefresh: true);
              Navigator.of(dialogCtx).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: const Text("Yes, Go Back"),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: LocaleKeys.checkout.tr(),
        onBack: _hasCheckoutStarted
            ? () async {
                final cubit = context.read<CheckoutCubit>();
                final orderId = cubit.checkoutResponse?.orderId;
                final paymentUrl = cubit.checkoutResponse?.paymentUrl;

                if (orderId != null && paymentUrl != null) {
                  await HiveStorageHelper().saveString(
                    "payment_url_order_$orderId",
                    paymentUrl,
                  );
                }
                final res = await _showAwaitingPaymentDialog(context);
                if (res) {
                  Navigator.of(context).pop();
                }
              }
            : null,
        enableLeading: true,
      ),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          final cubit = context.read<CheckoutCubit>();
          if (state is PaymentWebhookSuccess) {
            showSuccessSnackBar(messageTitle: "Payment Successful!");

            // 1. Refresh Cart (Remove checked out items)
            context.read<CartCubit>().isCartChanged = true;
            context.read<CartCubit>().getBasket();

            // 2. Refresh Orders screen list
            OrdersCubit.instance?.getOrders(isRefresh: true);

            // 3. Navigate to Order Details
            setState(() {
              _paymentSuccess = true;
            });
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.orderDetails,
              (route) => route.settings.name == Routes.mainLayout,
              arguments: OrderDetailsArgs(
                orderId: cubit.checkoutResponse?.orderId ?? 0,
              ),
            );
          } else if (state is PaymentWebhookError) {
            showFailureSnackBar(context, messageTitle: state.error.message);
          }
        },
        child: PopScope(
          canPop: !_hasCheckoutStarted || _paymentSuccess,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final cubit = context.read<CheckoutCubit>();

            // لسه معملش Checkout
            if (!_hasCheckoutStarted) {
              Navigator.of(context).pop();
              return;
            }

            // الدفع نجح
            if (_paymentSuccess) {
              Navigator.of(context).pop();
              return;
            }

            // عمل Checkout ولسه مستني الدفع
            final shouldPop = await _showAwaitingPaymentDialog(context);

            if (!shouldPop || !context.mounted) return;

            final orderId = cubit.checkoutResponse?.orderId;
            final paymentUrl = cubit.checkoutResponse?.paymentUrl;

            if (orderId != null && paymentUrl != null) {
              await HiveStorageHelper().saveString(
                "payment_url_order_$orderId",
                paymentUrl,
              );
            }

            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: CheckoutScreenBody(
            onCheckout: ({required isCheckoutSucess}) {
              setState(() {
                _hasCheckoutStarted = isCheckoutSucess;
              });
            },
          ),
        ),
      ),
    );
  }
}
