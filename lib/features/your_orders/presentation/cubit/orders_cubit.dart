import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/your_orders/domain/entities/order_status_filter.dart';
import 'package:tradehub/main.dart';
import '../../data/models/order_response_d_t_o.dart';
import '../../domain/use_cases/get_orders_use_case.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  static OrdersCubit? instance;

  OrdersCubit(this._getOrdersUseCase) : super(const OrdersState()) {
    instance = this;
  }

  Future<void> changeStatusFilter(OrderStatusFilter status) async {
    if (state.selectedStatus == status &&
        state.requestState == RequestStates.success) {
      return;
    }
    await getOrders(isRefresh: true, status: status);
  }

  Future<void> getOrders({
    bool isRefresh = false,
    OrderStatusFilter? status,
  }) async {
    final effectiveStatus = status ?? state.selectedStatus;
    final pageIndex = isRefresh ? 1 : state.pageIndex;

    if (isRefresh) {
      if (isClosed) return;
      emit(state.copyWith(
        requestState: RequestStates.loading,
        pageIndex: 1,
        hasReachedMax: false,
        orders: [],
        selectedStatus: effectiveStatus,
        isFetchingMore: false,
        errorMessage: null,
      ));
    } else {
      if (state.hasReachedMax || state.isFetchingMore) return;
      if (isClosed) return;
      if (state.pageIndex > 1) {
        emit(state.copyWith(isFetchingMore: true));
      } else {
        emit(state.copyWith(requestState: RequestStates.loading));
      }
    }

    final result = await _getOrdersUseCase.call(
      orderStatus: effectiveStatus.apiName,
      pageIndex: pageIndex,
      pageSize: 5,
    );

    if (isClosed) return;

    switch (result) {
      case Success():
        final response = result.data!;
        final newOrders = response.data ?? [];
        final totalCount = response.count ?? 0;
        final currentPage = response.pageIndex ?? pageIndex;
        final updatedOrders =
            isRefresh ? newOrders : [...state.orders, ...newOrders];
        final hasReachedMax =
            updatedOrders.length >= totalCount || newOrders.isEmpty;

        emit(state.copyWith(
          requestState: RequestStates.success,
          isFetchingMore: false,
          orders: updatedOrders,
          pageIndex: currentPage + 1,
          hasReachedMax: hasReachedMax,
        ));
      case Error():
        emit(state.copyWith(
          requestState: pageIndex == 1
              ? RequestStates.error
              : state.requestState,
          isFetchingMore: false,
          errorMessage: result.error?.message,
        ));
    }
  }
}
