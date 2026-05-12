import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../api/checkout_api_client.dart';
import '../data_source_contract/checkout_data_source.dart';
import '../models/request/checkout_request_d_t_o.dart';
import '../models/response/checkout_response_d_t_o.dart';
import '../models/response/payment_webhook_response_d_t_o.dart';

@Injectable(as: CheckoutDataSource)
class CheckoutDataSourceImpl implements CheckoutDataSource {
  final CheckoutApiClient _apiClient;

  CheckoutDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<CheckoutResponseDTO>> checkout({required CheckoutRequestDTO body}) {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.checkout(body: body),
    );
  }

  @override
  Future<ApiResult<void>> paymentWebhook({required PaymentWebhookRequest body}) {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.paymentWebhook(body: body),
    );
  }
}
