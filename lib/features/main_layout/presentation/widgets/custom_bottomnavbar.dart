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

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key, required this.getSelectedIndex,  required this.currentIndex});

  final Function(int) getSelectedIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {
        'activeIcon': Assets.icons.homeFilled,
        'icon': Assets.icons.home,
        'label': LocaleKeys.Home.tr(),
      },
      {
        'activeIcon': Assets.icons.myOrders,
        'icon': Assets.icons.myOrders,
        'label': LocaleKeys.yourOrders.tr(),
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
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.2)))),
      child: BottomNavigationBar(
        showUnselectedLabels: true,
        onTap: (value) {
          getSelectedIndex(value);
          
          
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: context.mainColor,
        unselectedItemColor:
            context.isDarkMode ? AppColors.white.withOpacity(0.6) : AppColors.grey,
        backgroundColor: context.isDarkMode ? AppColors.black : AppColors.white,
        elevation: 0,
        unselectedLabelStyle: context.base.theme.textTheme.bodyMedium
            ?.copyWith(fontSize: 11.sp, color: context.greyOrWhite),
        selectedLabelStyle:
            context.base.theme.textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
        items: navItems.map((item) {
          return BottomNavigationBarItem(
            activeIcon: SvgWidget(
              color: context.mainColor,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
              assetName: item['activeIcon'],
            ),
            icon: SvgWidget(
              color: context.isDarkMode
                  ? AppColors.white.withOpacity(0.6)
                  : AppColors.grey,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
              assetName: item['icon'],
            ),
            label: item['label'],
          );
        }).toList(),
      ),
    );
  }
}
