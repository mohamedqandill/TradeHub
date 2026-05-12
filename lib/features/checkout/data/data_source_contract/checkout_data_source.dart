import 'package:tradehub/core/api/api_result/api_result.dart';
import '../models/request/checkout_request_d_t_o.dart';
import '../models/response/checkout_response_d_t_o.dart';
import '../models/response/payment_webhook_response_d_t_o.dart';

abstract class CheckoutDataSource {
  Future<ApiResult<CheckoutResponseDTO>> checkout({required CheckoutRequestDTO body});
  Future<ApiResult<void>> paymentWebhook({required PaymentWebhookRequest body});
}
