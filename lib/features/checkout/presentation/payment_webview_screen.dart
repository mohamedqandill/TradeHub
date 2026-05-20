import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/features/checkout/data/models/response/payment_webhook_response_d_t_o.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;
  final CheckoutCubit cubit;
  final int? orderId;

  const PaymentWebViewScreen({
    super.key,
    required this.url,
    required this.cubit,
     this.orderId,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            final url = change.url ?? '';
            if (url.contains('localhost:4200/payment-result')) {
              _handlePaymentResult(url);
              Navigator.of(context).pop();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _handlePaymentResult(String url) {
    final uri = Uri.parse(url);
    final id = int.tryParse(uri.queryParameters['id'] ?? '');
    final pending = uri.queryParameters['pending'] == 'true';
    final success = uri.queryParameters['success'] == 'true';
    final integrationId =
        int.tryParse(uri.queryParameters['integration_id'] ?? '');
    final orderId = widget.cubit.checkoutResponse?.orderId ?? widget.orderId;
    final type = uri.queryParameters['source_data.type'];
    final pan = uri.queryParameters['source_data.pan'];
    final subType = uri.queryParameters['source_data.sub_type'];
    final request = PaymentWebhookRequest(
      obj: WebhookObject(
        sourceData: SourceData(
          type: type,
          pan: pan,
          subType: subType,
        ),
        id: id,
        success: success,
        pending: pending,
        extras: WebhookExtras(orderId: orderId),
        order: WebhookOrder(id: integrationId),
      ),
    );

    widget.cubit.paymentWebhook(body: request);
    widget.cubit.saveRequestData(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainLayoutAppBar(
        title: "Secure Payment",
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
