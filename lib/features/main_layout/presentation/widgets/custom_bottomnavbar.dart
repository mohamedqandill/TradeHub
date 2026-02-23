import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/svg_widget.dart';

import '../../../../Core/colors/app_colors.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key, required this.getSelectedIndex});

  final Function(int) getSelectedIndex;

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 1,
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.5)))),
      child: BottomNavigationBar(
        showUnselectedLabels: true,
        onTap: (value) {
          widget.getSelectedIndex(value);
          selectedIndex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: context.mainColor,
        unselectedItemColor:
            context.isDarkMode ? AppColors.white : AppColors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
        unselectedLabelStyle: context.base.theme.textTheme.bodyMedium
            ?.copyWith(fontSize: 11.sp, color: context.greyOrWhite),
        selectedLabelStyle:
            context.base.theme.textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
        items: [
          BottomNavigationBarItem(
              activeIcon: SvgWidget(
                color: context.mainColor,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
                assetName: Assets.icons.homeFilled,
              ),
              icon: SvgWidget(
                color: context.greyOrWhite,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
                assetName: Assets.icons.home,
              ),
              label: LocaleKeys.Home.tr()),
          BottomNavigationBarItem(
              activeIcon: SvgWidget(
                color: context.mainColor,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
                assetName: Assets.icons.favouriteFilled,
              ),
              icon: SvgWidget(
                color: context.greyOrWhite,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
                assetName: Assets.icons.favourite,
              ),
              label: LocaleKeys.Favourite.tr()),
          BottomNavigationBarItem(
              activeIcon: SvgWidget(
                color: context.mainColor,
                width: 22.w,
                fit: BoxFit.cover,
                height: 22.h,
                assetName: Assets.icons.cartFilled,
              ),
              icon: SvgWidget(
                color: context.greyOrWhite,
                width: 22.w,
                fit: BoxFit.cover,
                height: 22.h,
                assetName: Assets.icons.cart,
              ),
              label: LocaleKeys.Cart.tr()),
          BottomNavigationBarItem(
              activeIcon: SvgWidget(
                color: context.mainColor,
                width: 22.w,
                fit: BoxFit.cover,
                height: 22.h,
                assetName: Assets.icons.userFill,
              ),
              icon: SvgWidget(
                color: context.greyOrWhite,
                width: 22.w,
                fit: BoxFit.cover,
                height: 22.h,
                assetName: Assets.icons.user,
              ),
              label: LocaleKeys.Profile.tr()),
        ],
      ),
    );
  }
}
