import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import '../models/request/checkout_request_d_t_o.dart';
import '../models/response/checkout_response_d_t_o.dart';
import '../models/response/payment_webhook_response_d_t_o.dart';

part 'checkout_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _CheckoutApiClient;

  @POST(ApiEndPoints.checkout)
  Future<CheckoutResponseDTO> checkout({@Body() required  CheckoutRequestDTO body});

  @POST(ApiEndPoints.paymentWebhook)
  Future<void> paymentWebhook({@Body() required PaymentWebhookRequest body});
}
