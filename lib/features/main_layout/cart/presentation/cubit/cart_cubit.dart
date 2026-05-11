import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import 'package:tradehub/features/product_details/domain/use_cases/add_to_cart_usecase.dart';
import '../../domain/use_case/get_basket_usecase.dart';
import '../../domain/use_case/remove_basket_usecase.dart';
import '../../domain/use_case/remove_item_usecase.dart';
import '../../domain/use_case/update_item_quantity_usecase.dart';
import 'cart_states.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetBasketUseCase _getBasketUseCase;
  final RemoveBasketUseCase _removeBasketUseCase;
  final RemoveItemUseCase _removeItemUseCase;
  final UpdateItemQuantityUseCase _updateItemQuantityUseCase;
  final AddToCartUseCase _addToCartUseCase;

  List<CartResponseDTO>? cartGroups;
  int? loadingProductId;
  bool _isCartChanged = false;
  bool isCartInitated = false;

  CartCubit(
    this._getBasketUseCase,
    this._addToCartUseCase,
    this._removeBasketUseCase,
    this._removeItemUseCase,
    this._updateItemQuantityUseCase,
  ) : super(CartInitial());

  void getBasket() async {
    if (!_isCartChanged && isCartInitated) return;
    emit(GetBasketLoading());
    final result = await _getBasketUseCase.call();
    switch (result) {
      case Success():
        cartGroups = result.data;
        emit(GetBasketSuccess());
        _isCartChanged = false;
        isCartInitated = true;
      case Error():
        emit(GetBasketError(result.error?.message ?? "Failed To Get Cart"));
    }
  }

  Future<void> addToCart(int productId, {int quantity = 1}) async {
    loadingProductId = productId;
    emit(AddToCartLoadingState());
    var result = await _addToCartUseCase(productId, quantity: quantity);
    switch (result) {
      case Success():
        _isCartChanged = true;
        emit(AddToCartSuccessState());
        loadingProductId = null;
      case Error():
        emit(AddToCartErrorState(result.error?.message ?? "Error occurred"));
        loadingProductId = null;
    }
  }

  void removeBasket() async {
    emit(RemoveBasketLoading());
    final result = await _removeBasketUseCase();
    switch (result) {
      case Success():
        _isCartChanged = true;
        emit(RemoveBasketSuccess());
        // Refresh basket after removing
       
      case Error():
        emit(RemoveBasketError(
            result.error?.message ?? "Failed to clear basket"));
    }
  }

  void removeItem({required int companyId, required int productId}) async {
    emit(RemoveItemLoading(productId));
    final result = await _removeItemUseCase(companyId: companyId, productId: productId);
    switch (result) {
      case Success():
        _isCartChanged = true;
        emit(RemoveItemSuccess());
        // Refresh basket after removing item
        
      case Error():
        emit(RemoveItemError(result.error?.message ?? "Failed to remove item"));
    }
  }

  void updateItemQuantity({required int companyId, required int productId, required int quantity}) async {
    emit(UpdateItemQuantityLoading(companyId));
    final result = await _updateItemQuantityUseCase(companyId: companyId, productId: productId, quantity: quantity);
    switch (result) {
      case Success():
        _isCartChanged = true;
        emit(UpdateItemQuantitySuccess());
        
      case Error():
        emit(UpdateItemQuantityError(
            result.error?.message ?? "Failed to update quantity"));
    }
  }

void resetCart() {
  cartGroups = null;
  _isCartChanged = true;
  isCartInitated = false;
}}
