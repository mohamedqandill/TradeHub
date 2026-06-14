import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/saved_places_model.dart';

class SavedPlacesDatabase {
  static const kPlacesKey = 'SavedPlaces';

  Future<void> savePlace(SavedPlacesModel place) async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final box = await Hive.openBox<Map>(kPlacesKey, path: appDocumentsDir.path);
    await box.add(place.toJson());
    log('place saved: ${place.placeName}');
  }

  Future<List<SavedPlacesModel>> getPlaces() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final box = await Hive.openBox<Map>(kPlacesKey, path: appDocumentsDir.path);

    final places = <SavedPlacesModel>[];
    for (final key in box.keys) {
      final json = box.get(key);
      if (json != null) {
        places.add(SavedPlacesModel.fromJson(json));
      }
    }
    return places;
  }

  Future<void> clearSavedPlaces() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final box = await Hive.openBox<Map>(kPlacesKey, path: appDocumentsDir.path);
    await box.clear();
  }
}
