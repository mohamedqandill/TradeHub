part of 'checkout_cubit.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final CheckoutResponseDTO response;
  CheckoutSuccess(this.response);
}

class CheckoutError extends CheckoutState {
  final ErrorsModel error;
  CheckoutError(this.error);
}

class PaymentWebhookLoading extends CheckoutState {}

class PaymentWebhookSuccess extends CheckoutState {
  
}

class PaymentWebhookError extends CheckoutState {
  final ErrorsModel error;
  PaymentWebhookError(this.error);
}
