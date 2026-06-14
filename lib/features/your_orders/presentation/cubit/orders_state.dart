part of 'orders_cubit.dart';

class OrdersState {
  final RequestStates requestState;
  final List<OrderDataResponseDTO> orders;
  final OrderStatusFilter selectedStatus;
  final int pageIndex;
  final bool hasReachedMax;
  final bool isFetchingMore;
  final String? errorMessage;

  const OrdersState({
    this.requestState = RequestStates.initial,
    this.orders = const [],
    this.selectedStatus = OrderStatusFilter.processing,
    this.pageIndex = 1,
    this.hasReachedMax = false,
    this.isFetchingMore = false,
    this.errorMessage,
  });

  OrdersState copyWith({
    RequestStates? requestState,
    List<OrderDataResponseDTO>? orders,
    OrderStatusFilter? selectedStatus,
    int? pageIndex,
    bool? hasReachedMax,
    bool? isFetchingMore,
    String? errorMessage,
  }) {
    return OrdersState(
      requestState: requestState ?? this.requestState,
      orders: orders ?? this.orders,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      pageIndex: pageIndex ?? this.pageIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      errorMessage: errorMessage,
    );
  }
}
