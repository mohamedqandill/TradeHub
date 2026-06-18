import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';

@singleton
class SharedProductRepository {
  
  bool _hasUpdates = false;

  bool get hasUpdates => _hasUpdates;
  bool _isFavoriteChange = false;
  bool _isFirstTimeAtFavorite = true;

  bool get isFirstTimeAtFavorite => _isFirstTimeAtFavorite;

  bool get isFavoriteChange => _isFavoriteChange;

  void markThatFavoriteChange() {
    _isFavoriteChange = true;
  }

  void markFirstTimeAtFavorite() {
    _isFirstTimeAtFavorite = false;
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
