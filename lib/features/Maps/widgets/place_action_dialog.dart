import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_text_field.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/features/Maps/utils/db/db.dart';
import 'package:tradehub/features/Maps/utils/models/saved_places_model.dart';

class PlaceActionDialogResult {
  final String placeName;
  final bool saved;

  const PlaceActionDialogResult({
    required this.placeName,
    required this.saved,
  });
}

Future<PlaceActionDialogResult?> showPlaceActionDialog({
  required BuildContext context,
  required String placeName,
  required LatLng location,
  String? placeLabel,
  TextEditingController? controller,
}) async {
  final editController = controller ?? TextEditingController(text: placeName);
  final shouldDispose = controller == null;

  final result = await showDialog<PlaceActionDialogResult>(
    context: context,
    builder: (dialogContext) {
      return _PlaceActionDialog(
        initialName: placeName,
        placeLabel: placeLabel,
        controller: editController,
        location: location,
      );
    },
  );

  if (shouldDispose) {
    editController.dispose();
  }

  return result;
}

class _PlaceActionDialog extends StatefulWidget {
  final String initialName;
  final String? placeLabel;
  final TextEditingController controller;
  final LatLng location;

  const _PlaceActionDialog({
    required this.initialName,
    required this.placeLabel,
    required this.controller,
    required this.location,
  });

  @override
  State<_PlaceActionDialog> createState() => _PlaceActionDialogState();
}

class _PlaceActionDialogState extends State<_PlaceActionDialog> {
  bool _isSaving = false;

  Future<void> _savePlace() async {
    final name = widget.controller.text.trim();
    if (name.isEmpty) return;

    setState(() => _isSaving = true);

    await SharedPrefsHelper.init();
    await SharedPrefsHelper().saveString(AppConstants.savedPlace, name);
    await SavedPlacesDatabase().savePlace(
      SavedPlacesModel(
        latitude: widget.location.latitude,
        longitude: widget.location.longitude,
        placeName: name,
        placeCountry: widget.placeLabel ?? widget.initialName,
      ),
    );

    if (!mounted) return;
    Navigator.pop(
      context,
      PlaceActionDialogResult(placeName: name, saved: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: context.mainColor.withOpacity(isDark ? 0.2 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.location_on_rounded, color: context.mainColor),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              LocaleKeys.deliveryAddressText.tr(),
              style: context.base.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.placeLabel?.isNotEmpty == true) ...[
              Text(
                widget.placeLabel!,
                style: context.base.theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12.h),
            ],
            CustomTextField(controller: widget.controller),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: Text(
            LocaleKeys.cancel.tr(),
            style: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.mainColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: _isSaving ? null : _savePlace,
          child: _isSaving
              ? SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(LocaleKeys.save.tr()),
        ),
      ],
    );
  }
}
