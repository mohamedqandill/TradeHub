import 'package:latlong2/latlong.dart';
import 'package:tradehub/features/Maps/utils/models/PlacesAutoCompleteModel.dart';

class MapsState {
  final LatLng? currentLocation;
  final bool gotLocation;
  final LatLng? selectedLocation;
  final String? selectedPlaceName;
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
    List<Features>? places,
    bool? isLoading,
    bool? isPlacesLoading,
    bool? isFocusedState,
    String? errorMessage,
    String? snackBarMessage,
  }) {
    return MapsState(
      currentLocation: currentLocation ?? this.currentLocation,
      gotLocation: gotLocation ?? this.gotLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedPlaceName: selectedPlaceName ?? this.selectedPlaceName,
      places: places ?? this.places,
      isLoading: isLoading ?? this.isLoading,
      isPlacesLoading: isPlacesLoading ?? this.isPlacesLoading,
      isFocusedState: isFocusedState ?? this.isFocusedState,
      errorMessage: errorMessage,
      snackBarMessage: snackBarMessage,
    );
  }
}
