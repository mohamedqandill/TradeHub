import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../../domain/repo_contract/checkout_repository.dart';
import '../data_source_contract/checkout_data_source.dart';
import '../models/request/checkout_request_d_t_o.dart';
import '../models/response/checkout_response_d_t_o.dart';
import '../models/response/payment_webhook_response_d_t_o.dart';

@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutDataSource _dataSource;

  CheckoutRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<CheckoutResponseDTO>> checkout({required CheckoutRequestDTO body}) {
    return _dataSource.checkout(body: body);
  }

  @override
  Future<ApiResult<void>> paymentWebhook({required PaymentWebhookRequest body}) {
    return _dataSource.paymentWebhook(body: body);
  }
}
