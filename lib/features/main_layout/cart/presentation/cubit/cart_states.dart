import '../../data/models/cart_response_d_t_o.dart';

sealed class CartState {}

class CartInitial extends CartState {}

class GetBasketLoading extends CartState {}
class GetBasketSuccess extends CartState {

}
class GetBasketError extends CartState {
  final String? message;
  GetBasketError(this.message);
}
class AddToCartLoadingState extends CartState {}

class AddToCartSuccessState extends CartState {}

class AddToCartErrorState extends CartState {
  final String message;
  AddToCartErrorState(this.message);
}

class RemoveBasketLoading extends CartState {}
class RemoveBasketSuccess extends CartState {}
class RemoveBasketError extends CartState {
  final String message;
  RemoveBasketError(this.message);
}

class RemoveItemLoading extends CartState {
  final int id;
  RemoveItemLoading(this.id);
}
class RemoveItemSuccess extends CartState {}
class RemoveItemError extends CartState {
  final String message;
  RemoveItemError(this.message);
}

class UpdateItemQuantityLoading extends CartState {
  final int id;
  UpdateItemQuantityLoading(this.id);
}
class UpdateItemQuantitySuccess extends CartState {}
class UpdateItemQuantityError extends CartState {
  final String message;
  UpdateItemQuantityError(this.message);
}
