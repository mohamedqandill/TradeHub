import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  String savedPlaceName = "";
  final List<String> availablePlaces = [
    "Menoufia, Markaz Elbagour",
    "No Place Selected"
  ];

  @override
  void initState() {
    getSavedPlaceName();
    super.initState();
  }

  getSavedPlaceName() {
    String currentPlace =
        getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ??
            "No Place Selected";
    savedPlaceName = currentPlace;
    if (!availablePlaces.contains(currentPlace)) {
      availablePlaces.insert(0, currentPlace);
    }
    setState(() {});
  }

  void _onAddressChanged(String newAddress) {
    setState(() {
      savedPlaceName = newAddress;
      getIt<SharedPrefsHelper>()
          .saveString(AppConstants.savedPlace, newAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    Color cardColor =
        isDarkMode ? AppColors.black.withOpacity(0.3) : AppColors.white;
    Color textColor = isDarkMode ? AppColors.white : AppColors.black;

    return Scaffold(
      appBar: MainLayoutAppBar(
        title: LocaleKeys.savedAddresses.tr(),
        enableLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                await Navigator.pushNamed(context, Routes.flutterMap);
                getSavedPlaceName();
              },
              child: Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: context.greyOrWhite.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 48.w,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: context.mainColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgWidget(
                            width: 20.w,
                            height: 20.h,
                            fit: BoxFit.cover,
                            assetName: isDarkMode
                                ? Assets.icons.addressDark
                                : Assets.icons.address),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.chooseNewAddress.tr(),
                          style: context.base.theme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          LocaleKeys.selectFromMapOrSavedList.tr(),
                          style:
                              context.base.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: availablePlaces.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                String place = availablePlaces[index];
                bool isSelected = savedPlaceName == place;
                return GestureDetector(
                  onTap: () {
                    _onAddressChanged(place);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: isSelected && !isDarkMode
                          ? context.mainColor.withOpacity(0.05)
                          : cardColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected
                            ? context.mainColor
                            : context.greyOrWhite.withOpacity(0.1),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        if (!isDarkMode)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 48.w,
                          width: 48.w,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.mainColor.withOpacity(0.1)
                                : (isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.blue[50]),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.location_on_outlined,
                                color: isSelected
                                    ? context.mainColor
                                    : (isDarkMode
                                        ? Colors.white
                                        : Colors.blue[300]),
                                size: 24.sp),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place,
                                style: context.base.theme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              if (isSelected) ...[
                                SizedBox(height: 6.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.grey[800]
                                        : AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    LocaleKeys.defaultText.tr(),
                                    style: context
                                        .base.theme.textTheme.labelSmall
                                        ?.copyWith(
                                      color: isDarkMode
                                          ? Colors.white
                                          : AppColors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: CustomLargeMainButton(
          text: LocaleKeys.save.tr(),
          radius: 25.r,
          textStyle: context.base.theme.textTheme.titleLarge!
              .copyWith(color: AppColors.white, fontSize: 16.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
