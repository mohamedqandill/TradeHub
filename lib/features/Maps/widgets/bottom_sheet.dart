import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_text_field.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/features/Maps/view_model/maps_cubit.dart';

Widget buildBottomSection(BuildContext context, String placeName,
    final MapsCubit cubit, final TextEditingController editController) {
  ;
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
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Container(
              height: 48.h,
              width: 48.w,
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
            SizedBox(width: 16.w),
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
                  SizedBox(height: 4.h),
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
            SizedBox(width: 10.w),
            InkWell(
                onTap: () {
                  editController.text = placeName;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: context.isDarkMode
                            ? Colors.grey[800]
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Text(
                          LocaleKeys.edit.tr(),
                          style: context.base.theme.textTheme.titleMedium
                              ?.copyWith(
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: CustomTextField(
                            controller: editController,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(LocaleKeys.cancel.tr(),
                                style: const TextStyle(color: Colors.grey)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.mainColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              cubit.updatePlaceName(editController.text);
                              Navigator.pop(context);
                            },
                            child: Text(LocaleKeys.save.tr()),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.edit, color: context.mainColor, size: 20.w)),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                context.isDarkMode ? Colors.grey[800] : const Color(0xffF4F6F9),
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
        SizedBox(height: 24.h),
        CustomLargeMainButton(
          text: LocaleKeys.confirmLocation.tr(),
          radius: 25.r,
          textStyle: context.base.theme.textTheme.titleLarge!
              .copyWith(color: AppColors.white, fontSize: 16.sp),
          onPressed: () async {
            await SharedPrefsHelper.init();
            await SharedPrefsHelper()
                .saveString(AppConstants.savedPlace, placeName);
            if (context.mounted) {
              Navigator.pop(context, placeName);
            }
          },
        )
      ],
    ),
  );
}
