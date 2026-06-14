import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tradehub/features/Maps/utils/models/PlacesAutoCompleteModel.dart';

class MapsState {
  final LatLng? currentLocation;
  final bool gotLocation;
  final LatLng? selectedLocation;
  final String? selectedPlaceName;
  final String? selectedPlaceLabel;
  final List<Features> places;
  final bool isLoading;
  final bool isPlacesLoading;
  final bool isFocusedState;
  final String? errorMessage;
  final String? snackBarMessage;

  const MapsState({
    this.currentLocation,
    this.gotLocation = false,
    this.selectedLocation,
    this.selectedPlaceName,
    this.selectedPlaceLabel,
    this.places = const [],
    this.isLoading = false,
    this.isPlacesLoading = false,
    this.isFocusedState = false,
    this.errorMessage,
    this.snackBarMessage,
  });

  MapsState copyWith({
    LatLng? currentLocation,
    bool? gotLocation,
    LatLng? selectedLocation,
    String? selectedPlaceName,
    String? selectedPlaceLabel,
    List<Features>? places,
    bool? isLoading,
    bool? isPlacesLoading,
    bool? isFocusedState,
    String? errorMessage,
    String? snackBarMessage,
    bool clearSelection = false,
  }) {
    return MapsState(
      currentLocation: currentLocation ?? this.currentLocation,
      gotLocation: gotLocation ?? this.gotLocation,
      selectedLocation:
          clearSelection ? null : (selectedLocation ?? this.selectedLocation),
      selectedPlaceName: clearSelection
          ? null
          : (selectedPlaceName ?? this.selectedPlaceName),
      selectedPlaceLabel: clearSelection
          ? null
          : (selectedPlaceLabel ?? this.selectedPlaceLabel),
      places: places ?? this.places,
      isLoading: isLoading ?? this.isLoading,
      isPlacesLoading: isPlacesLoading ?? this.isPlacesLoading,
      isFocusedState: isFocusedState ?? this.isFocusedState,
      errorMessage: errorMessage,
      snackBarMessage: snackBarMessage,
    );
  }
}
