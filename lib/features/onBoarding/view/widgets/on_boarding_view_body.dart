import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/app_assets.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/custom_main_button.dart';
import 'package:tradehub/core/shared_widgets/custom_main_outline_button.dart';
import 'package:tradehub/core/shared_widgets/main_logo.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

import '../../../../core/localization/locale_keys.g.dart';
import 'custom_body_widget.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late final PageController pageController;
  late SharedPrefsHelper prefs;
  int currentPage = 0;

  @override
  void initState() {
    prefs = SharedPrefsHelper();
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  saveOnBoardingState() async {
    await prefs.saveBool(AppConstants.firstTime, false);
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  var controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    List<OnBoardingBodyData> onBoardingData = [
      OnBoardingBodyData(
          title:
              "${LocaleKeys.shopSmarter.tr()},\n${LocaleKeys.tradeBetter.tr()}",
          image: AppAssets.blackGirl,
          subTitles: LocaleKeys.discoverTopProduct.tr()),
      OnBoardingBodyData(
          title: LocaleKeys.securePayment.tr(),
          image: AppAssets.onlinePayment,
          subTitles: LocaleKeys.expSeamless.tr()),
      OnBoardingBodyData(
          title: LocaleKeys.trackOrder.tr(),
          image: AppAssets.trackOrder,
          subTitles: LocaleKeys.stayUpdate.tr()),
    ];
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 17.sp),
              child: AdvancedSwitch(
                thumb: !controller.value
                    ? Image.asset(AppAssets.america)
                    : Image.asset(AppAssets.egypt),
                controller: controller,
                activeColor: context.isDarkMode
                    ? Colors.white
                    : AppColors.grey.withOpacity(0.3),
                inactiveColor:
                    context.isDarkMode ? Colors.white : AppColors.mainColor,
                activeChild: context.locale.languageCode == AppConstants.en
                    ? Text(
                        AppConstants.enCap,
                        style: TextStyle(
                            color: context.isDarkMode
                                ? AppColors.black
                                : Colors.white),
                      )
                    : Text(
                        AppConstants.arCap,
                        style: TextStyle(
                            color: context.isDarkMode
                                ? AppColors.black
                                : Colors.white),
                      ),
                inactiveChild: context.locale.languageCode == AppConstants.en
                    ? Text(
                        AppConstants.enCap,
                        style: TextStyle(
                            color: context.isDarkMode
                                ? AppColors.black
                                : Colors.white),
                      )
                    : Text(
                        AppConstants.arCap,
                        style: TextStyle(
                            color: context.isDarkMode
                                ? AppColors.black
                                : Colors.white),
                      ),
                borderRadius: BorderRadius.all(Radius.circular(35.r)),
                width: 64.0,
                height: 30.0,
                enabled: true,
                disabledOpacity: 0.5,
                initialValue: controller.value,
                onChanged: (value) {
                  controller.value = value;
                  print(controller.value);
                  if (controller.value == true) {
                    context.setLocale(const Locale(AppConstants.ar));
                  } else {
                    context.setLocale(const Locale(AppConstants.en));
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height > 800 ? 10.h : 5.h,
          ),
          const Center(child: MainLogo()),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onBoardingData.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return CustomBodyWidget(
                    image: onBoardingData[index].image,
                    title: onBoardingData[index].title,
                    subTitle: onBoardingData[index].subTitles);
              },
            ),
          ),
          currentPage == 2
              ? CustomMainButton(
                  text: LocaleKeys.getStarted.tr(),
                  width: 335.w,
                  height: 48.h,
                  onPressed: () {
                    saveOnBoardingState();
                  },
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomMainOutlineButton(
                      text: LocaleKeys.skip.tr(),
                      onPressed: () {
                        saveOnBoardingState();
                      },
                    ),
                    CustomMainButton(
                      text: LocaleKeys.next.tr(),
                      onPressed: () {
                        if (pageController.page! < 2.0) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInSine);
                        }
                      },
                    )
                  ],
                ),
          SizedBox(
            height: 40.h,
          ),
          Directionality(
            textDirection: context.locale.languageCode == AppConstants.ar
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            child: SmoothPageIndicator(
              controller: pageController,
              // PageController
              count: 3,
              axisDirection: Axis.horizontal,

              effect: WormEffect(
                  activeDotColor: context.isDarkMode
                      ? AppColors.mainDarkColor
                      : AppColors.mainColor),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

class OnBoardingBodyData {
  final String title, subTitles, image;

  OnBoardingBodyData(
      {required this.title, required this.image, required this.subTitles});
}
