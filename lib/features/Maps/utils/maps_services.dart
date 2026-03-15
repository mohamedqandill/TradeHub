import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constants.dart';
import 'models/PlacesAutoCompleteModel.dart';

class MapsApiServices {
  Dio dio = Dio();
  MapsApiServices() {
    dio.options = BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        }));
  }

  Future<String> getPlaceName(LatLng point) async {
    try {
      var response = await dio.get(
          "https://api.openrouteservice.org/geocode/reverse?api_key=$apiKey&point.lon=${point.longitude}&point.lat=${point.latitude}");
      if (response.statusCode == 200) {
        final features = response.data['features'] as List;
        if (features.isNotEmpty) {
          return features[0]['properties']['name'] ??
              features[0]['properties']['label'] ??
              "Unknown Place";
        }
      }
      return "Selected Location";
    } catch (e) {
      log("Error=>${e.toString()}");
      return "Unknown Location";
    }
  }

  getPlaces(String query) async {
    try {
      // var encodedQuery = Uri.encodeComponent(query);
      var response = await dio.get(
          "https://api.openrouteservice.org/geocode/autocomplete?api_key=$apiKey&text=$query");
      if (response.statusCode == 200) {
        var data = PlacesAutoCompleteModel.fromJson(response.data);
        List<Features>? places = data.features;
        print("places=>>${data.features!.length}");
        return places;
      }
    } catch (e) {
      print("Error=>${e.toString()}");
      rethrow;
    }
  }
}
