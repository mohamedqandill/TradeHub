import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:tradehub/features/Maps/utils/location_services.dart';
import 'package:tradehub/features/Maps/utils/maps_services.dart';
import 'package:tradehub/features/Maps/utils/models/saved_places_model.dart';
import 'package:tradehub/features/Maps/view_model/maps_cubit.dart';
import 'package:tradehub/features/Maps/view_model/maps_state.dart';
import 'package:tradehub/features/Maps/widgets/place_action_dialog.dart';
import 'package:tradehub/features/Maps/widgets/custom_list_view.dart';
import 'package:tradehub/features/Maps/widgets/map_search_field.dart';

class FlutterMapScreen extends StatelessWidget {
  const FlutterMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapsCubit(LocationService(), MapsApiServices())
        ..ensureLocationServiceAvailable(),
      child: const FlutterMapScreenBody(),
    );
  }
}

class FlutterMapScreenBody extends StatefulWidget {
  const FlutterMapScreenBody({super.key});

  @override
  State<FlutterMapScreenBody> createState() => _FlutterMapScreenBodyState();
}

class _FlutterMapScreenBodyState extends State<FlutterMapScreenBody> {
  GoogleMapController? _mapController;
  late final TextEditingController _searchController;
  late final TextEditingController _editController;
  bool _isFirstLocation = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _editController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.addListener(() {
        if (!mounted) return;
        context.read<MapsCubit>().onSearchTextChanged(_searchController.text);
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _editController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _animateTo(LatLng latLng) async {
    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );
  }

  Future<void> _showPlaceDialog({
    required String placeName,
    required LatLng location,
    String? placeLabel,
  }) async {
    final result = await showPlaceActionDialog(
      context: context,
      placeName: placeName,
      location: location,
      placeLabel: placeLabel,
      controller: _editController,
    );

    if (!mounted || result?.saved != true) return;
    Navigator.pop(context, result!.placeName);
  }

  Future<void> _handlePlaceSelection({
    required String placeName,
    required LatLng latLng,
    String? placeLabel,
  }) async {
    context.read<MapsCubit>().selectPlace(
          placeName,
          latLng,
          placeLabel: placeLabel,
        );
    await _animateTo(latLng);
    await _showPlaceDialog(
      placeName: placeName,
      location: latLng,
      placeLabel: placeLabel ?? placeName,
    );
  }

  Future<void> _handleMapTap(LatLng point) async {
    final cubit = context.read<MapsCubit>();
    await cubit.addDestinationMarker(point);
    final state = cubit.state;
    if (state.selectedPlaceName == null || state.selectedLocation == null) {
      return;
    }

    await _animateTo(state.selectedLocation!);
    await _showPlaceDialog(
      placeName: state.selectedPlaceName!,
      location: state.selectedLocation!,
      placeLabel: state.selectedPlaceLabel,
    );
  }

  Future<void> _handleMyLocation() async {
    final cubit = context.read<MapsCubit>();
    final state = cubit.state;

    if (state.currentLocation == null) {
      cubit.updateMyLocation();
      return;
    }

    await _animateTo(state.currentLocation!);
    await cubit.addDestinationMarker(state.currentLocation!);

    final updated = cubit.state;
    if (updated.selectedPlaceName != null) {
      await _showPlaceDialog(
        placeName: updated.selectedPlaceName!,
        location: state.currentLocation!,
        placeLabel: updated.selectedPlaceLabel,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<MapsCubit, MapsState>(
      listenWhen: (previous, current) =>
          previous.snackBarMessage != current.snackBarMessage ||
          previous.currentLocation != current.currentLocation,
      listener: (context, state) {
        if (state.snackBarMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.snackBarMessage!)),
          );
          context.read<MapsCubit>().clearSnackBarMessage();
        }

        if (state.currentLocation != null && _isFirstLocation) {
          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: state.currentLocation!, zoom: 15),
            ),
          );
          _isFirstLocation = false;
        }
      },
      builder: (context, state) {
        final markers = <Marker>{};

        if (state.currentLocation != null) {
          markers.add(
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: state.currentLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
            ),
          );
        }

        if (state.selectedLocation != null) {
          markers.add(
            Marker(
              markerId: const MarkerId('selectedLocation'),
              position: state.selectedLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(30.0444, 31.2357),
                    zoom: 12,
                  ),
                  onTap: _handleMapTap,
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                ),
              ),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator()),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MapSearchTextField(
                        hintText: LocaleKeys.searchYourLocation.tr(),
                        isFocused: (isFocused) {
                          context.read<MapsCubit>().setFocusedState(isFocused);
                        },
                        controller: _searchController,
                      ),
                      if (state.isPlacesLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        CustomListView(
                          onPlaceSelected: (placeName, label, latLng) {
                            _handlePlaceSelection(
                              placeName: placeName,
                              latLng: latLng,
                              placeLabel: label,
                            );
                          },
                          onSavedPlaceSelected: (SavedPlacesModel place) {
                            _handlePlaceSelection(
                              placeName: place.placeName,
                              latLng: LatLng(
                                place.latitude,
                                place.longitude,
                              ),
                              placeLabel: place.placeCountry,
                            );
                          },
                          places: state.places,
                          currentLocation:
                              state.currentLocation ?? const LatLng(0, 0),
                          textEditingController: _searchController,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: context.mainColor,
            onPressed: _handleMyLocation,
            child: Icon(
              Icons.my_location,
              color: Colors.white,
              size: size.width * 0.07,
            ),
          ),
        );
      },
    );
  }
}
