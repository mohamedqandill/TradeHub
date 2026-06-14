import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/saved_places_model.dart';

class SavedPlacesDatabase {
  static const kPlacesKey = 'SavedPlaces';

  // static Future<void> deleteMovie(SavedPlacesModel place) async {
  //   final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  //
  //   // Open the box directly
  //   var box = await Hive.openBox<Map>(kPlacesKey, path: appDocumentsDir.path);
  //
  //   await box.delete(place);
  // }

  // Save a movie to the local storage
  Future<void> savePlace(SavedPlacesModel place) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open the box directly
    var box = await Hive.openBox<Map>(kPlacesKey, path: appDocumentsDir.path);

    await box.add(place.toJson()); // Use movie ID as the key
    log("place saved: ${place.placeName}");
  }

  // Retrieve all saved movies
  Future<List<SavedPlacesModel>> getPlaces() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open the box directly
    var box = await Hive.openBox<Map>(kPlacesKey, path: appDocumentsDir.path);

    // Get all values from the box
    List<SavedPlacesModel> movies = [];

    // Iterate over all keys in the box
    for (var key in box.keys) {
      var json = box.get(key);
      if (json != null) {
        movies.add(SavedPlacesModel.fromJson(json));
        // Deserialize and add to list
      }
    }

    return movies;
  }

  // Clear all saved films from local storage
  Future<void> clearSavedPlaces() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox<Map>(kPlacesKey, path: appDocumentsDir.path);
    await box.clear();
    print("All saved Places have been cleared.");
  }
}
