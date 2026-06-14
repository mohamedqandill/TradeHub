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
          if (options.path.contains('/posts')) {
            return false;
          }
          return !args.isResponse || !args.hasUint8ListData;
        }));
  }

  Future<String> getPlaceName(LatLng point) async {
    try {
      var response = await dio.get(
          "https://api.openrouteservice.org/geocode/reverse?api_key=$apiKey&point.lon=${point.longitude}&point.lat=${point.latitude}&size=1");
      if (response.statusCode == 200) {
        final features = response.data['features'] as List;
        if (features.isNotEmpty) {
          final props = features[0]['properties'];
          final name = props['name'];
          final street = props['street'];
          final locality =
              props['locality'] ?? props['region'] ?? props['county'];

          final parts = <String>[];
          if (name != null) {
            if (double.tryParse(name.toString()) != null && street != null) {
              parts.add('$name $street');
            } else {
              parts.add(name.toString());
            }
          } else if (street != null) {
            parts.add(street.toString());
          }

          if (locality != null && (parts.isEmpty || parts[0] != locality)) {
            parts.add(locality.toString());
          }

          if (parts.isNotEmpty) return parts.join(', ');
          return props['label'] ?? 'Selected Location';
        }
      }
      return 'Selected Location';
    } catch (e) {
      log('Error=>${e.toString()}');
      return 'Unknown Location';
    }
  }

  Future<List<Features>?> getPlaces(String query) async {
    try {
      var response = await dio.get(
          "https://api.openrouteservice.org/geocode/autocomplete?api_key=$apiKey&text=$query");
      if (response.statusCode == 200) {
        var data = PlacesAutoCompleteModel.fromJson(response.data);
        return data.features;
      }
    } catch (e) {
      log('Error=>${e.toString()}');
      rethrow;
    }
    return null;
  }
}
