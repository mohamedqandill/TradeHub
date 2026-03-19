import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_text_field.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:tradehub/features/Maps/utils/location_services.dart';
import 'package:tradehub/features/Maps/utils/maps_services.dart';
import 'package:tradehub/features/Maps/view_model/maps_cubit.dart';
import 'package:tradehub/features/Maps/view_model/maps_state.dart';
import 'package:tradehub/features/Maps/widgets/bottom_sheet.dart';

import 'widgets/custom_list_view.dart';
import 'widgets/map_search_field.dart';

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
  GoogleMapController? mapController;
  late TextEditingController textEditingController;
  late TextEditingController editController;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    editController = TextEditingController();
    textEditingController.addListener(() {
      context.read<MapsCubit>().onSearchTextChanged(textEditingController.text);
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return BlocConsumer<MapsCubit, MapsState>(
      listenWhen: (previous, current) =>
          previous.snackBarMessage != current.snackBarMessage ||
          previous.currentLocation != current.currentLocation,
      listener: (context, state) {
        if (state.snackBarMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.snackBarMessage!)),
          );
        }

        if (state.currentLocation != null && isFirstTime) {
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: state.currentLocation!, zoom: 15),
            ),
          );
          isFirstTime = false;
        }
      },
      builder: (context, state) {
        Set<Marker> markers = {};
        if (state.currentLocation != null) {
          markers.add(Marker(
            markerId: const MarkerId('currentLocation'),
            position: state.currentLocation!,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ));
        }
        if (state.selectedLocation != null) {
          markers.add(Marker(
            markerId: const MarkerId('selectedLocation'),
            position: state.selectedLocation!,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ));
        }

        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) => mapController = controller,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(27.892458365561065, 26.725024118954433),
                  zoom: 5,
                ),
                onTap: (point) {
                  context.read<MapsCubit>().addDestinationMarker(point);
                },
                markers: markers,
              ),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator()),
              Positioned(
                top: height * 0.06,
                right: width * 0.05,
                left: width * 0.05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MapSearchTextField(
                      hintText: LocaleKeys.searchYourLocation.tr(),
                      isFocused: (isFocused) {
                        context.read<MapsCubit>().setFocusedState(isFocused);
                      },
                      controller: textEditingController,
                    ),
                    if (state.isPlacesLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.01),
                        child: CustomListView(
                          onPlaceSelected: (placeName, latLng) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<MapsCubit>()
                                .selectPlace(placeName, latLng);
                            mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(target: latLng, zoom: 15),
                              ),
                            );
                            textEditingController.text = placeName;
                          },
                          places: state.places,
                          currentLocation:
                              state.currentLocation ?? const LatLng(0, 0),
                          textEditingController: textEditingController,
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
          bottomSheet: state.selectedPlaceName != null
              ? buildBottomSection(context, state.selectedPlaceName!,
                  context.read<MapsCubit>(), editController)
              : null,
          floatingActionButton: FloatingActionButton(
            backgroundColor: context.mainColor, // or suitable color
            onPressed: () {
              if (state.currentLocation != null) {
                mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(target: state.currentLocation!, zoom: 15),
                  ),
                );
              } else {
                context.read<MapsCubit>().updateMyLocation();
              }
            },
            child: Icon(Icons.my_location,
                size: width * 0.07, color: Colors.white),
          ),
        );
      },
    );
  }
}
