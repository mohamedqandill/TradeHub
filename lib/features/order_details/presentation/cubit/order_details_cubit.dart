import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/order_details/domain/use_cases/cancel_order_use_case.dart';
import 'package:tradehub/features/order_details/domain/use_cases/get_order_details_use_case.dart';
import 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;
  OrderDetailsCubit(this._getOrderDetailsUseCase , this._cancelOrderUseCase)
      : super(OrderDetailsInitial());

  Future<void> getOrderDetails(int id) async {
    emit(GetOrderDetailsLoading());
    final result = await _getOrderDetailsUseCase.execute(id);
    switch (result) {
      case Success():
        emit(GetOrderDetailsSuccess(result.data!));

      case Error():
        emit(GetOrderDetailsError(
            result.error?.message ?? "Failed to fetch order details"));
    }
  }

  Future<void> cancelOrder(int id) async {
    emit(CancelOrderLoading());
    final result = await _cancelOrderUseCase.call(id: id);
    switch (result) {
      case Success():
        emit(CancelOrderSuccess("Order cancelled successfully"));
      case Error():
        emit(CancelOrderError(
            result.error?.message ?? "Failed to cancel order"));
    }
  }
}
