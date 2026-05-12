import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_errors/api_error_model.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../../data/models/order_response_d_t_o.dart';
import '../../domain/use_cases/get_orders_use_case.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;

  OrdersCubit(this._getOrdersUseCase) : super(OrdersInitial());

  Future<void> getOrders() async {
    emit(GetOrdersLoading());
    final result = await _getOrdersUseCase.call();
    switch (result) {
      case Success():
        emit(GetOrdersSuccess(result.data!));
      case Error():
        emit(GetOrdersError(result.error!));
    }
  }
}
