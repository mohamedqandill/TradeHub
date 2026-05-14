import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_errors/api_error_model.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import '../../data/models/request/checkout_request_d_t_o.dart';
import '../../data/models/response/checkout_response_d_t_o.dart';
import '../../data/models/response/payment_webhook_response_d_t_o.dart';
import '../../domain/use_cases/checkout_use_case.dart';
import '../../domain/use_cases/payment_webhook_use_case.dart';

part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutUseCase _checkoutUseCase;
  final PaymentWebhookUseCase _paymentWebhookUseCase;
  CartResponseDTO? items;
  CheckoutResponseDTO? checkoutResponse;
  String? address;
  PaymentWebhookRequest? paymentRequest;

  CheckoutCubit(this._checkoutUseCase, this._paymentWebhookUseCase)
      : super(CheckoutInitial());

  Future<void> checkout({required CheckoutRequestDTO body}) async {
    emit(CheckoutLoading());
    final result = await _checkoutUseCase.call(body: body);
    switch (result) {
      case Success():
        checkoutResponse = result.data;
        emit(CheckoutSuccess(result.data!));
      case Error():
        emit(CheckoutError(result.error!));
    }
  }

  Future<void> paymentWebhook({required PaymentWebhookRequest body}) async {
    emit(PaymentWebhookLoading());
    final result = await _paymentWebhookUseCase.call(body: body);
    switch (result) {
      case Success():
        emit(PaymentWebhookSuccess());
      case Error():
        emit(PaymentWebhookError(result.error!));
    }
  }

  getCheckoutData({required CartResponseDTO cartItems, required String address}) {
    items = cartItems;
    this.address = address;
  }
  saveRequestData(PaymentWebhookRequest body){
    paymentRequest = body;
  }
}
