import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

import '../../../../Core/assets/app_assets.dart';
import '../../../../core/constants/app_constants.dart';

class CustomSettingsRowInfo extends StatefulWidget {
  const CustomSettingsRowInfo({
    super.key,
    required this.title,
    required this.onTapped,
    required this.index,
    required this.isArabic,
  });

  final String title;
  final void Function() onTapped;
  final int index;
  final bool isArabic;

  @override
  State<CustomSettingsRowInfo> createState() => _CustomSettingsRowInfoState();
}

class _CustomSettingsRowInfoState extends State<CustomSettingsRowInfo> {
  late ValueNotifier<bool> controller;
  @override
  void initState() {
    controller = ValueNotifier(widget.isArabic);
    super.initState();
  }

  @override
  void didUpdateWidget(CustomSettingsRowInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isArabic != widget.isArabic) {
      controller.value = widget.isArabic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapped,
      child: Row(
        children: [
          SizedBox(
            width: 15.w,
          ),
          Text(
            widget.title,
            style: context.base.theme.textTheme.titleLarge?.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          widget.index == 4
              ? AdvancedSwitch(
                  thumb: !controller.value
                      ? Image.asset(AppAssets.america)
                      : Image.asset(AppAssets.egypt),
                  controller: controller,
                  activeColor: context.isDarkMode
                      ? Colors.white
                      : AppColors.grey.withOpacity(0.3),
                  inactiveColor: context.isDarkMode
                      ? Colors.white
                      : AppColors.grey.withOpacity(0.3),
                  activeChild: Text(
                    context.locale.languageCode.toUpperCase(),
                    style: TextStyle(
                      color:
                          context.isDarkMode ? AppColors.black : Colors.white,
                    ),
                  ),
                  inactiveChild: Text(
                    context.locale.languageCode.toUpperCase(),
                    style: TextStyle(
                      color:
                          context.isDarkMode ? AppColors.black : Colors.white,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(35.r)),
                  width: 64.0,
                  height: 30.0,
                  disabledOpacity: 0.5,
                  onChanged: (value) {
                    controller.value = value;
                    print(value);
                    if (controller.value == true) {
                      context.setLocale(const Locale(AppConstants.ar));
                    } else {
                      context.setLocale(const Locale(AppConstants.en));
                    }
                    setState(() {});
                  },
                )
              : Row(
                  children: [
                    widget.index == 3
                        ? Text(
                            "Enabled",
                            style: context.base.theme.textTheme.titleLarge!
                                .copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.grey,
                                    decorationColor: Colors.grey,
                                    decorationThickness: 2,
                                    decoration: TextDecoration.underline),
                          )
                        : const SizedBox(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 25.sp,
                      color: context.isDarkMode ? AppColors.white : null,
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
