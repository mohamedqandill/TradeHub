
import 'package:tradehub/features/offers/data/models/offers_response.dart';

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersLoaded extends OffersState {
  final OffersResponse offersResponse;
  OffersLoaded(this.offersResponse);
}

class OffersError extends OffersState {
  final String message;
  OffersError(this.message);
}

class OfferDetailsLoading extends OffersState {}

class OfferDetailsLoaded extends OffersState {
}

class OfferDetailsError extends OffersState {
  final String message;
  OfferDetailsError(this.message);
}

class AddOfferToCartLoading extends OffersState {}

class AddOfferToCartLoaded extends OffersState {

}

class AddOfferToCartError extends OffersState {
  final String message;
  AddOfferToCartError(this.message);
}
