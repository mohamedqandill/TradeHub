part of 'orders_cubit.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class GetOrdersLoading extends OrdersState {}

class GetOrdersSuccess extends OrdersState {
  final List<OrderResponseDTO> orders;
  GetOrdersSuccess(this.orders);
}

class GetOrdersError extends OrdersState {
  final ErrorsModel error;
  GetOrdersError(this.error);
}
