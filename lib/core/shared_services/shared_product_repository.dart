import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';

@singleton
class SharedProductRepository {
  // List<GetRandomProductEntity> randomProducts = [];

  // final _controller =
  //     StreamController<List<GetRandomProductEntity>>.broadcast();

  // Stream<List<GetRandomProductEntity>> get stream => _controller.stream;

  // void setProducts(List<GetRandomProductEntity> products) {
  //   randomProducts = products;
  //   for (var e in randomProducts) {
  //     print("LIST ITEM ID: ${e.id} | TYPE: ${e.id.runtimeType}");
  //   }
  //   _controller.add(List.from(randomProducts));
  // }

  // void updateRandomProducts(
  //     {required int id, bool? isFavorite, int? ratingCount, int? avgRating}) {

  //   final index = randomProducts.indexWhere((e) => e.id == id);
  //   print(index);
  //   if (index != -1) {
  //     final old = randomProducts[index];
  //     final newProduct = old.copyWith(
  //       isFavourite: isFavorite ?? old.isFavourite,
  //       ratingCount: ratingCount ?? old.ratingCount,
  //       averageRating: avgRating ?? old.averageRating,
  //     );
  //     print(isFavorite);
  //     randomProducts[index] = newProduct;
  //     print("productUpdated=> ${newProduct.isFavourite}");

  //     _controller.add(List.from(randomProducts));
  //   }
  // }
  bool _hasUpdates = false;

  bool get hasUpdates => _hasUpdates;
  bool _isFavoriteChange = false;

  bool get isFavoriteChange => _isFavoriteChange;

  void markThatFavoriteChange() {
    _isFavoriteChange = true;
  }

  void markUpdated() {
    _hasUpdates = true;
  }

  void clearUpdates() {
    _hasUpdates = false;
  }

  void clearFavoriteStateUpdate() {
    _isFavoriteChange = false;
  }
}
