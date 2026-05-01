abstract class ProductRatingsStates {}

class ProductRatingsInitialState extends ProductRatingsStates {}

class GetProductRatingsLoadingState extends ProductRatingsStates {}

class GetProductRatingsSuccessState extends ProductRatingsStates {}

class GetProductRatingsErrorState extends ProductRatingsStates {
  final String message;
  GetProductRatingsErrorState(this.message);
}

class AddProductRatingLoadingState extends ProductRatingsStates {}

class AddProductRatingSuccessState extends ProductRatingsStates {}

class AddProductRatingErrorState extends ProductRatingsStates {
  final String message;
  AddProductRatingErrorState(this.message);
}

