import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tradehub/features/Maps/utils/location_services.dart';
import 'package:tradehub/features/Maps/utils/maps_services.dart';

import 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final LocationService _locationService;
  final MapsApiServices _mapsApiServices;
  Timer? _debounce;
  bool locationRequested = false;

  MapsCubit(this._locationService, this._mapsApiServices)
      : super(const MapsState());

  Future<void> ensureLocationServiceAvailable() async {
    bool enabled = await requestService();
    if (!enabled) {
      emit(state.copyWith(snackBarMessage: "Please enable GPS to continue"));
      await Future.delayed(const Duration(seconds: 3));
      ensureLocationServiceAvailable();
    } else {
      locationRequested = true;
      updateMyLocation(isFirstTime: true);
    }
  }

  Future<bool> requestService() async {
    try {
      await _locationService.checkAndRequestPermission();
      return await _locationService.checkAndRequestLocationService();
    } catch (e) {
      log(e.toString());
      return await requestService();
    }
  }

  Future<void> updateMyLocation({bool isFirstTime = false}) async {
    if (state.gotLocation) return;

    if (!state.gotLocation && state.isFocusedState && isFirstTime) {
      emit(state.copyWith(snackBarMessage: "Getting Your Location....."));
    }

    Timer timeoutTimer = Timer(const Duration(seconds: 5), () {
      if (!state.gotLocation) {
        updateMyLocation();
      }
    });

    _locationService.getRealTimeLocationData((locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        timeoutTimer.cancel();
        final latLng = LatLng(locationData.latitude!, locationData.longitude!);

        emit(state.copyWith(
          gotLocation: true,
          currentLocation: latLng,
        ));
      } else {
        emit(state.copyWith(
            snackBarMessage: "Unable to get location. Trying again..."));
        Future.delayed(const Duration(seconds: 2), () {
          updateMyLocation();
        });
      }
    });
  }

  void onSearchTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 900), () async {
      if (text.isNotEmpty) {
        emit(state.copyWith(isPlacesLoading: true));
        try {
          final places = await _mapsApiServices.getPlaces(text);
          emit(state.copyWith(isPlacesLoading: false, places: places));
        } catch (e) {
          emit(state.copyWith(isPlacesLoading: false, places: []));
        }
      } else {
        emit(state.copyWith(places: []));
      }
    });
  }

  void setFocusedState(bool isFocused) {
    emit(state.copyWith(isFocusedState: isFocused));
  }

  void selectPlace(String placeName, LatLng latLng) {
    emit(state.copyWith(
      selectedPlaceName: placeName,
      selectedLocation: latLng,
      isFocusedState: false,
    ));
  }

  Future<void> addDestinationMarker(LatLng point) async {
    emit(state.copyWith(
      isLoading: true,
      selectedLocation: point,
    ));

    try {
      String placeName = await _mapsApiServices.getPlaceName(point);
      emit(state.copyWith(
        selectedPlaceName: placeName,
        selectedLocation: point,
        isFocusedState: false,
        isLoading: false,
      ));
    } catch (e) {
      log("Error fetching place: ${e.toString()}");
      emit(state.copyWith(isLoading: false));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
