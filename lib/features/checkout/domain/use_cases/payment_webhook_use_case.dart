import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../../data/models/response/payment_webhook_response_d_t_o.dart';
import '../repo_contract/checkout_repository.dart';

@injectable
class PaymentWebhookUseCase {
  final CheckoutRepository _repository;

  PaymentWebhookUseCase(this._repository);

  Future<ApiResult<void>> call({required PaymentWebhookRequest body}) {
    return _repository.paymentWebhook(body: body);
  }
}
