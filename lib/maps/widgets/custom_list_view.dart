// import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:tradehub/features/Maps/utils/maps_services.dart';
// import 'package:tradehub/features/Maps/utils/models/PlacesAutoCompleteModel.dart';
// import 'package:tradehub/features/Maps/utils/models/saved_places_model.dart';

// import '../utils/db/db.dart';

// class CustomListView extends StatefulWidget {
//   const CustomListView({
//     super.key,
//     required this.places,
//     required this.mapsApiServices,
//     required this.currentLocation,
//     required this.textEditingController,
//     required this.onRouteUpdate,
//   });

//   final List<Features> places;
//   final MapsApiServices mapsApiServices;

//   final LatLng currentLocation;
//   final Function(List<LatLng>, LatLng destination, bool listenerState,
//       bool loadingState, List placeSegments) onRouteUpdate;
//   final TextEditingController textEditingController;

//   @override
//   State<CustomListView> createState() => _CustomListViewState();
// }

// class _CustomListViewState extends State<CustomListView> {
//   bool isLoading = false;
//   late SavedPlacesDatabase savedPlacesDatabase;
//   List<SavedPlacesModel> savedPlaces = [];
//   late List segments;
//   int placeId = 0;

//   @override
//   void initState() {
//     savedPlacesDatabase = SavedPlacesDatabase();
//     getAllSavedPlaces();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;

//     return savedPlaces.isEmpty && widget.textEditingController.text.isEmpty
//         ? const SizedBox()
//         : Container(
//             height: widget.textEditingController.text.isEmpty
//                 ? height * 0.7
//                 : height * 0.99,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(width * 0.025),
//             ),
//             child: widget.places.isEmpty &&
//                     widget.textEditingController.text.isNotEmpty
//                 ? Center(
//                     child: Text(
//                       "No Places Found",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: width * 0.06,
//                       ),
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       widget.textEditingController.text.isEmpty
//                           ? Padding(
//                               padding: EdgeInsets.only(
//                                 top: height * 0.02,
//                                 left: width * 0.04,
//                                 right: width * 0.04,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Recent",
//                                     style: TextStyle(
//                                       fontSize: width * 0.06,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       savedPlacesDatabase.clearSavedPlaces();
//                                       savedPlaces = [];
//                                       setState(() {});
//                                     },
//                                     child: Text(
//                                       "Clear All",
//                                       style: TextStyle(
//                                         fontSize: width * 0.05,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           : const SizedBox(),
//                       Expanded(
//                         child: ListView.separated(
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () {
//                                 final coords =
//                                     widget.textEditingController.text.isEmpty
//                                         ? [0.0, 0.0]
//                                         : widget.places[index].geometry!
//                                             .coordinates!;
//                                 final savedCoords =
//                                     widget.textEditingController.text.isEmpty
//                                         ? savedPlaces[index].latLng
//                                         : const LatLng(0, 0);
//                                 final lon = coords[0];
//                                 final lat = coords[1];
//                                 final latLng = LatLng(lat, lon);
//                                 FocusScope.of(context).unfocus();
//                                 if (widget
//                                     .textEditingController.text.isNotEmpty) {
//                                   SavedPlacesModel place = SavedPlacesModel(
//                                     latLng: latLng,
//                                     placeName:
//                                         widget.places[index].properties?.name ??
//                                             "",
//                                     placeCountry: widget
//                                             .places[index].properties?.label ??
//                                         "", latitude: null,
//                                   );
//                                   savePlaceToDB(place);
//                                 }

//                                 getRoutes(
//                                   index,
//                                   widget.textEditingController.text.isEmpty
//                                       ? savedCoords
//                                       : latLng,
//                                 );

//                                 setState(() {
//                                   Future.delayed(
//                                     const Duration(milliseconds: 500),
//                                     () {
//                                       widget.textEditingController.clear();
//                                     },
//                                   );
//                                   getAllSavedPlaces();
//                                 });
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.all(width * 0.025),
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on,
//                                       size: width * 0.075,
//                                     ),
//                                     SizedBox(width: width * 0.025),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             widget.textEditingController.text
//                                                     .isEmpty
//                                                 ? savedPlaces[index].placeName
//                                                 : widget.places[index]
//                                                         .properties?.name ??
//                                                     "Error",
//                                             style: TextStyle(
//                                               fontSize: width * 0.052,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           Text(
//                                             widget.textEditingController.text
//                                                     .isEmpty
//                                                 ? savedPlaces[index]
//                                                     .placeCountry
//                                                 : widget.places[index]
//                                                         .properties?.label ??
//                                                     "Error",
//                                             style: TextStyle(
//                                               fontSize: width * 0.045,
//                                               fontWeight: FontWeight.w300,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     Icon(
//                                       Icons.arrow_circle_right_outlined,
//                                       size: width * 0.075,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return Divider(
//                               color: Colors.black,
//                               thickness: width * 0.003,
//                             );
//                           },
//                           itemCount: widget.textEditingController.text.isEmpty
//                               ? savedPlaces.length
//                               : widget.places.length,
//                         ),
//                       ),
//                     ],
//                   ),
//           );
//   }

//   getAllSavedPlaces() async {
//     savedPlaces = await savedPlacesDatabase.getPlaces();
//     setState(() {});
//     print("${savedPlaces.length}");
//   }

//   getRoutes(int index, LatLng latLng) async {
//     var newRoutes;
//     widget.onRouteUpdate([], latLng, false, true, []);
//     try {
//       var result =
//           await widget.mapsApiServices.getRoute(widget.currentLocation, latLng);
//       newRoutes = result['routePoints'];
//       segments = result['segments'];
//     } catch (e) {
//       widget.onRouteUpdate([], latLng, false, false, []);
//       return;
//     }
//     widget.onRouteUpdate(newRoutes, latLng, false, false, segments);
//   }

//   savePlaceToDB(SavedPlacesModel place) async {
//     await savedPlacesDatabase.savePlace(place);
//   }
// }
