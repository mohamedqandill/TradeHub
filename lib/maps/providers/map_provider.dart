import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tradehub/features/Maps/utils/location_services.dart';
import 'package:tradehub/features/Maps/utils/maps_services.dart';
import 'package:tradehub/features/Maps/utils/models/PlacesAutoCompleteModel.dart';

class MapProvider with ChangeNotifier, WidgetsBindingObserver {
  final LocationService locationService = LocationService();
  final MapsApiServices mapsApiServices = MapsApiServices();

  GoogleMapController? mapController;

  Set<Marker> markers = {};
  LatLng currentLocation = const LatLng(30.0444, 31.2357);
  LatLng? selectedLocation;
  String? selectedPlaceName;
  String? selectedPlaceLabel;
  List<Features> places = [];

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  bool isLoading = false;
  bool isPlacesLoading = false;
  bool ignoreListener = false;

  StreamSubscription? locationSubscription;
  Timer? debounce;
  bool _isInitial = true;

  MapProvider() {
    WidgetsBinding.instance.addObserver(this);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final text = searchController.text;
    if (ignoreListener || text.isEmpty) {
      places = [];
      notifyListeners();
      return;
    }

    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 600), () async {
      isPlacesLoading = true;
      notifyListeners();
      try {
        places = await mapsApiServices.getPlaces(text) ?? [];
      } catch (_) {
        places = [];
      }
      isPlacesLoading = false;
      notifyListeners();
    });
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      requestServiceAndLocation();
    }
  }

  Future<void> requestServiceAndLocation() async {
    final hasPermission = await locationService.checkAndRequestPermission();
    final isEnabled = await locationService.isServiceEnabled();
    if (hasPermission && isEnabled) {
      updateMyLocation();
    }
  }

  Future<void> forceRequestService() async {
    await locationService.checkAndRequestPermission();
    final enabled = await locationService.checkAndRequestLocationService();
    if (enabled) {
      updateMyLocation();
    }
  }

  Future<void> updateMyLocation() async {
    locationSubscription?.cancel();
    locationService.getRealTimeLocationData((locationData) async {
      if (locationData.latitude == null || locationData.longitude == null) {
        return;
      }

      currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
      _refreshMarkers();

      if (_isInitial) {
        await mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 14),
          ),
        );
        _isInitial = false;
      }

      notifyListeners();
    });
  }

  Future<void> selectPlace(Features place) async {
    final coords = place.geometry!.coordinates!;
    final latLng = LatLng(coords[1], coords[0]);
    final name = place.properties?.name ?? 'Selected Location';
    final label = place.properties?.label ?? name;

    selectedLocation = latLng;
    selectedPlaceName = name;
    selectedPlaceLabel = label;
    places = [];

    ignoreListener = true;
    searchController.text = name;
    ignoreListener = false;

    _refreshMarkers();
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );
    notifyListeners();
  }

  Future<void> selectPointOnMap(LatLng point) async {
    isLoading = true;
    notifyListeners();

    final name = await mapsApiServices.getPlaceName(point);
    selectedLocation = point;
    selectedPlaceName = name;
    selectedPlaceLabel = name;
    isLoading = false;

    _refreshMarkers();
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 15),
      ),
    );
    notifyListeners();
  }

  void updateSelectedPlaceName(String name) {
    selectedPlaceName = name;
    notifyListeners();
  }

  void clearSelection() {
    selectedLocation = null;
    selectedPlaceName = null;
    selectedPlaceLabel = null;
    _refreshMarkers();
    notifyListeners();
  }

  void _refreshMarkers() {
    markers = {
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
      if (selectedLocation != null)
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: selectedLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
    };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchController.dispose();
    searchFocus.dispose();
    debounce?.cancel();
    locationSubscription?.cancel();
    mapController?.dispose();
    super.dispose();
  }
}
