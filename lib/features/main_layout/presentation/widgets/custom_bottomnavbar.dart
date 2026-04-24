import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/widgets/svg_widget.dart';

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
    final List<Map<String, dynamic>> navItems = [
      {
        'activeIcon': Assets.icons.homeFilled,
        'icon': Assets.icons.home,
        'label': LocaleKeys.Home.tr(),
      },
      {
        'activeIcon': Assets.icons.categoryFilled,
        'icon': Assets.icons.category,
        'label': LocaleKeys.explore.tr(),
      },
      {
        'activeIcon': Assets.icons.cartFilled,
        'icon': Assets.icons.cart,
        'label': LocaleKeys.Cart.tr(),
      },
      {
        'activeIcon': Assets.icons.userFill,
        'icon': Assets.icons.user,
        'label': LocaleKeys.Profile.tr(),
      },
    ];

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
        items: navItems.map((item) {
          return BottomNavigationBarItem(
            activeIcon: item['activeIcon'] == Assets.icons.categoryFilled
                ? Icon(
                    Icons.category,
                    color: context.mainColor,
                    size: 24.sp,
                  )
                : SvgWidget(
                    color: context.mainColor,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.cover,
                    assetName: item['activeIcon'],
                  ),
            icon: item['icon'] == Assets.icons.category
                ? Icon(
                    Icons.category_outlined,
                    color: context.greyOrWhite,
                    size: 24.sp,
                  )
                : SvgWidget(
                    color: context.greyOrWhite,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.cover,
                    assetName: item['icon'],
                  ),
            label: item['label'],
          );
        }).toList(),
      ),
    );
  }
}
