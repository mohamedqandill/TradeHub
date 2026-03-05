import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/constants/app_constants.dart';
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
  late MapController mapController;
  late TextEditingController textEditingController;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    textEditingController = TextEditingController();
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
          mapController.move(state.currentLocation!, 15);
          isFirstTime = false;
        }
      },
      builder: (context, state) {
        List<Marker> markers = [];
        if (state.currentLocation != null) {
          markers.add(Marker(
            point: state.currentLocation!,
            child:
                Icon(Icons.my_location, size: width * 0.09, color: Colors.blue),
          ));
        }
        if (state.selectedLocation != null) {
          markers.add(Marker(
            point: state.selectedLocation!,
            child: Icon(Icons.location_on,
                size: width * 0.09, color: context.mainColor),
          ));
        }

        return Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter:
                      const LatLng(27.892458365561065, 26.725024118954433),
                  initialZoom: 5,
                  onTap: (tapPosition, point) {
                    context.read<MapsCubit>().addDestinationMarker(point);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName: 'com.example.flutter_map',
                  ),
                  MarkerLayer(markers: markers),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
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
                    else if (state.isFocusedState)
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.01),
                        child: CustomListView(
                          onPlaceSelected: (placeName, latLng) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<MapsCubit>()
                                .selectPlace(placeName, latLng);
                            mapController.move(latLng, 15);
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
              ? _buildBottomSection(context, state.selectedPlaceName!)
              : null,
          floatingActionButton: FloatingActionButton(
            backgroundColor: context.mainColor, // or suitable color
            onPressed: () {
              if (state.currentLocation != null) {
                mapController.move(state.currentLocation!, 15);
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

  Widget _buildBottomSection(BuildContext context, String placeName) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xff1A1A1A) : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? context.mainColor.withOpacity(0.2)
                      : context.mainColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.location_on, color: context.mainColor),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.deliveryAddressText.tr(),
                      style: context.base.theme.textTheme.bodySmall?.copyWith(
                        color: context.isDarkMode
                            ? Colors.grey[400]
                            : const Color(0xff8C92A4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      placeName,
                      style: context.base.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.edit, color: context.mainColor, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.grey[800]
                  : const Color(0xffF4F6F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info,
                    color: context.isDarkMode
                        ? Colors.grey[400]
                        : const Color(0xff8C92A4),
                    size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    LocaleKeys.dragMapAdjustPin.tr(),
                    style: context.base.theme.textTheme.bodySmall?.copyWith(
                      color: context.isDarkMode
                          ? Colors.grey[300]
                          : const Color(0xff575F75),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          CustomLargeMainButton(
            text: LocaleKeys.confirmLocation.tr(),
            radius: 25.r,
            textStyle: context.base.theme.textTheme.titleLarge!
                .copyWith(color: AppColors.white, fontSize: 16.sp),
            onPressed: () async {
              await SharedPrefsHelper.init();
              await SharedPrefsHelper()
                  .saveString(AppConstants.savedPlace, placeName);
              if (mounted) {
                Navigator.pop(context, placeName);
              }
            },
          )
        ],
      ),
    );
  }
}
