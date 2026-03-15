import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/Maps/utils/models/PlacesAutoCompleteModel.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({
    super.key,
    required this.places,
    required this.currentLocation,
    required this.textEditingController,
    required this.onPlaceSelected,
  });

  final List<Features> places;
  final LatLng currentLocation;
  final Function(String, LatLng) onPlaceSelected;
  final TextEditingController textEditingController;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    if (widget.textEditingController.text.isEmpty) {
      return const SizedBox();
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: height * 0.4,
      ),
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
        child: widget.places.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: Text(
                    "No Places Found",
                    style: context.base.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color:
                          context.isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.places.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: context.isDarkMode
                      ? Colors.grey[800]
                      : const Color(0xffF0F0F0),
                  indent: 64.w,
                  endIndent: 20.w,
                ),
                itemBuilder: (context, index) {
                  final place = widget.places[index];
                  final placeName = place.properties?.name ?? "Unknown Place";
                  final placeLabel = place.properties?.label ?? "";

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        final coords = place.geometry!.coordinates!;
                        final lon = coords[0];
                        final lat = coords[1];
                        final latLng = LatLng(lat, lon);

                        FocusScope.of(context).unfocus();
                        widget.onPlaceSelected(placeName, latLng);

                        setState(() {
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              if (mounted) widget.textEditingController.clear();
                            },
                          );
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: Center(
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: context.mainColor,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    placeName,
                                    style: context
                                        .base.theme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (placeLabel.isNotEmpty &&
                                      placeLabel != placeName) ...[
                                    SizedBox(height: 4.h),
                                    Text(
                                      placeLabel,
                                      style: context
                                          .base.theme.textTheme.bodySmall
                                          ?.copyWith(
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
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14.sp,
                              color: context.isDarkMode
                                  ? Colors.grey[600]
                                  : const Color(0xffC4C4C4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
