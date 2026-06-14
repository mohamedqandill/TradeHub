import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/Maps/utils/db/db.dart';
import 'package:tradehub/features/Maps/utils/models/PlacesAutoCompleteModel.dart';
import 'package:tradehub/features/Maps/utils/models/saved_places_model.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({
    super.key,
    required this.places,
    required this.currentLocation,
    required this.textEditingController,
    required this.onPlaceSelected,
    required this.onSavedPlaceSelected,
  });

  final List<Features> places;
  final LatLng currentLocation;
  final TextEditingController textEditingController;
  final void Function(String name, String label, LatLng latLng) onPlaceSelected;
  final void Function(SavedPlacesModel place) onSavedPlaceSelected;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final SavedPlacesDatabase _savedPlacesDatabase = SavedPlacesDatabase();
  List<SavedPlacesModel> _savedPlaces = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPlaces();
  }

  Future<void> _loadSavedPlaces() async {
    final places = await _savedPlacesDatabase.getPlaces();
    if (mounted) {
      setState(() => _savedPlaces = places.reversed.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final isSearching = widget.textEditingController.text.isNotEmpty;

    if (!isSearching && _savedPlaces.isEmpty) {
      return const SizedBox();
    }

    return Container(
      constraints: BoxConstraints(maxHeight: height * 0.4),
      margin: EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xff1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isSearching && _savedPlaces.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Places',
                      style: context.base.theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: context.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _savedPlacesDatabase.clearSavedPlaces();
                        await _loadSavedPlaces();
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: context.mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Flexible(
              child: isSearching
                  ? _buildSearchResults(context)
                  : _buildSavedPlaces(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    if (widget.places.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Center(
          child: Text(
            'No Places Found',
            style: context.base.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: widget.places.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        thickness: 1,
        color: context.isDarkMode ? Colors.grey[800] : const Color(0xffF0F0F0),
        indent: 64.w,
        endIndent: 20.w,
      ),
      itemBuilder: (context, index) => _buildPlaceTile(
        context: context,
        title: widget.places[index].properties?.name ?? 'Unknown Place',
        subtitle: widget.places[index].properties?.label ?? '',
        onTap: () {
          final coords = widget.places[index].geometry!.coordinates!;
          final latLng = LatLng(coords[1], coords[0]);
          final name = widget.places[index].properties?.name ?? 'Unknown Place';
          final label = widget.places[index].properties?.label ?? name;

          FocusScope.of(context).unfocus();
          widget.onPlaceSelected(name, label, latLng);
          widget.textEditingController.text = name;
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted) widget.textEditingController.clear();
          });
        },
      ),
    );
  }

  Widget _buildSavedPlaces(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _savedPlaces.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        thickness: 1,
        color: context.isDarkMode ? Colors.grey[800] : const Color(0xffF0F0F0),
        indent: 64.w,
        endIndent: 20.w,
      ),
      itemBuilder: (context, index) {
        final place = _savedPlaces[index];
        return _buildPlaceTile(
          context: context,
          title: place.placeName,
          subtitle: place.placeCountry,
          onTap: () {
            FocusScope.of(context).unfocus();
            widget.onSavedPlaceSelected(place);
          },
        );
      },
    );
  }

  Widget _buildPlaceTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? context.mainColor.withOpacity(0.15)
                      : context.mainColor.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  color: context.mainColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.base.theme.textTheme.titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle.isNotEmpty && subtitle != title) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style:
                            context.base.theme.textTheme.bodySmall?.copyWith(
                          color: context.isDarkMode
                              ? Colors.grey[400]
                              : const Color(0xff8C92A4),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
