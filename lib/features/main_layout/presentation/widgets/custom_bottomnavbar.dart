import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

import '../../../../Core/assets/app_assets.dart';
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
          border: Border(top: BorderSide(width: 1, color: context.mainColor))),
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
        selectedLabelStyle:
            context.base.theme.textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
        items: [
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                AppAssets.homeIconFilled,
                color: context.mainColor,
              ),
              icon: Image.asset(
                AppAssets.homeIcon,
              ),
              label: LocaleKeys.Home.tr()),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                AppAssets.favIcon,
                color: context.mainColor,
              ),
              icon: Image.asset(
                AppAssets.favIcon,
              ),
              label: LocaleKeys.Favourite.tr()),
          BottomNavigationBarItem(
              activeIcon:
                  Image.asset(color: context.mainColor, AppAssets.cartFilled),
              icon: Image.asset(AppAssets.cart),
              label: LocaleKeys.Cart.tr()),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                  color: context.mainColor, AppAssets.profileIconFilled),
              icon: Image.asset(AppAssets.profileIcon),
              label: LocaleKeys.Profile.tr()),
        ],
      ),
    );
  }
}
