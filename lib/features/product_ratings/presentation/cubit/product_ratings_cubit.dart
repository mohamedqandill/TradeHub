import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';
import 'package:tradehub/features/product_ratings/domain/use_cases/add_product_rating_usecase.dart';
import 'package:tradehub/features/product_ratings/domain/use_cases/get_product_ratings_usecase.dart';
import 'package:tradehub/features/product_ratings/presentation/cubit/product_ratings_states.dart';

@injectable
class ProductRatingsCubit extends Cubit<ProductRatingsStates> {
  final GetProductRatingsUseCase _getProductRatingsUseCase;
  final AddProductRatingUseCase _addProductRatingUseCase;

  ProductRatingsCubit(
    this._getProductRatingsUseCase,
    this._addProductRatingUseCase,
  ) : super(ProductRatingsInitialState());

  List<ProductRatingDTO> productRatings = const [];

  Future<void> getProductRatings(int productId) async {
    emit(GetProductRatingsLoadingState());
    final result = await _getProductRatingsUseCase(productId);
    if (result is Success<List<ProductRatingDTO>>) {
      productRatings = result.data ?? const [];
      emit(GetProductRatingsSuccessState());
    } else if (result is Error<List<ProductRatingDTO>>) {
      emit(GetProductRatingsErrorState(
        result.error?.message ?? "Error occurred",
      ));
    }
  }

  Future<void> addProductRating({
    required int productId,
    required int ratingValue,
    required String comment,
  }) async {
    emit(AddProductRatingLoadingState());
    final result = await _addProductRatingUseCase(
      productId: productId,
      ratingValue: ratingValue,
      comment: comment,
    );

    if (result is Success<ProductRatingDTO>) {
      await getProductRatings(productId);
      emit(AddProductRatingSuccessState());
    } else if (result is Error<ProductRatingDTO>) {
      emit(AddProductRatingErrorState(
        result.error?.message ?? "Error occurred",
      ));
    }
  }
}

