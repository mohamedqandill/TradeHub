abstract class ProductDetailsStates {}

class ProductDetailsInitialState extends ProductDetailsStates {}

class GetProductDetailsLoadingState extends ProductDetailsStates {}

class GetProductDetailsSuccessState extends ProductDetailsStates {}

class GetProductDetailsErrorState extends ProductDetailsStates {
  final String message;
  GetProductDetailsErrorState(this.message);
}



class ToggleFavoriteLoadingState extends ProductDetailsStates {}

class ToggleFavoriteSuccessState extends ProductDetailsStates {}

class ToggleFavoriteErrorState extends ProductDetailsStates {
  final String message;
  ToggleFavoriteErrorState(this.message);
}
