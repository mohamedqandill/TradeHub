import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_search_field.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String address;
  final VoidCallback onPlaceSelected;

  const HomeHeaderWidget(
      {super.key, required this.address, required this.onPlaceSelected});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        color: context.mainColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 16.h,
          left: 16.w,
          right: 16.w,
          bottom: 50.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
                Center(
                  child: SvgWidget(
                    height: 25.h,
                    width: 20.w,
                    fit: BoxFit.cover,
                    assetName: context.isDarkMode
                        ? Assets.icons.addressDark
                        : Assets.icons.address,
                    color: Colors.white,
                ),
              ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.deliverTo.tr(),
                      style: context.base.theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white70,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          address,
                          style:
                              context.base.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                            await Navigator.pushNamed(
                                context, Routes.flutterMap);
                        onPlaceSelected();
                      },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 20.sp,
                                color: Colors.white,
                          ),
                        )
                        ],
                      ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.favourite);
                  },
                  child: Padding(
                    padding: context.locale.languageCode == AppConstants.ar
                        ? EdgeInsets.only(left: 8.w)
                        : EdgeInsets.only(right: 8.w),
                    child: Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgWidget(
                          width: 20.w,
                          height: 20.h,
                          fit: BoxFit.cover,
                          assetName: Assets.icons.favouriteFilled,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: context.locale.languageCode == AppConstants.ar
                      ? EdgeInsets.only(left: 4.w)
                      : EdgeInsets.only(right: 4.w),
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgWidget(
                        width: 20.w,
                        height: 20.h,
                        fit: BoxFit.cover,
                        assetName: context.isDarkMode
                        ? Assets.icons.notificationDark
                        : Assets.icons.notification,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            ],
          ),
          SizedBox(height: 24.h),
          Container(
            decoration: BoxDecoration(
              color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
                borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                )
              ],
            ),
            child: CustomSearchField(
              prefixIcon: Icon(
                Icons.search_rounded,
                  size: 24.sp,
                  color: context.isDarkMode
                      ? AppColors.white.withOpacity(0.6)
                      : AppColors.grey.withOpacity(0.6),
              ),
              hintText: LocaleKeys.searchForProducts.tr(),
            ),
            ),
        ],
      ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 50);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
