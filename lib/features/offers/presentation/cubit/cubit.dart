
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/offers/data/models/add_offer_request_body.dart';
import 'package:tradehub/features/offers/data/models/offers_response.dart';
import 'package:tradehub/features/offers/data/repo/offers_repo.dart';
import 'package:tradehub/features/offers/presentation/cubit/state.dart';
import 'package:injectable/injectable.dart';




@injectable
class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this._offersRepo) : super(OffersInitial());

  final OffersRepo _offersRepo;
     OfferResponse? offerResponse;


  Future<void> getOffers() async {
    emit(OffersLoading());
    final result = await _offersRepo.getOffers();

    switch(result){
      case Success(data: final data):
        emit(OffersLoaded(data!));
      case Error(error: final error):
        emit(OffersError(error!.message));
    }

  }

   Future<void> getOfferDetails(int id) async {
    emit(OfferDetailsLoading());
    final result = await _offersRepo.getOfferDetails(id);

    switch(result){
      case Success(data: final data):
        offerResponse = data!;
        emit(OfferDetailsLoaded());
      case Error(error: final error):
        emit(OfferDetailsError(error!.message));
    }

  }

  Future<void> addOfferToCart({required AddOfferRequestBody addOfferRequestBody}) async {
    emit(AddOfferToCartLoading());
    final result = await _offersRepo.addOfferToCart(addOfferRequestBody: addOfferRequestBody);

    switch(result){
      case Success():
        emit(AddOfferToCartLoaded());
      case Error(error: final error):
        emit(AddOfferToCartError(error!.message));
    }

  }
}