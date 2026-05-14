import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';

sealed class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}

class GetOrderDetailsLoading extends OrderDetailsState {}

class GetOrderDetailsSuccess extends OrderDetailsState {
  final OrderDetailsResponseDTO orderDetails;
  GetOrderDetailsSuccess(this.orderDetails);
}

class GetOrderDetailsError extends OrderDetailsState {
  final String message;
  GetOrderDetailsError(this.message);
}
