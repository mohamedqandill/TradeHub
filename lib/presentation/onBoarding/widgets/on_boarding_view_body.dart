import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tradehub/core/assets/app_assets.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/custom_main_outline_button.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/presentation/onBoarding/widgets/custom_body_widget.dart';

import '../../../core/localization/local_keys/local_keys.dart';
import '../../../core/shared_widgets/custom_main_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height > 800 ? 70.h : 30.h,
        ),
        Center(
          child: SvgPicture.asset(
            AppAssets.mainLogo,
          ),
        ),
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
                text: LocalKeys.getStarted.tr(),
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
                    text: LocalKeys.skip.tr(),
                    onPressed: () {
                      saveOnBoardingState();
                    },
                  ),
                  CustomMainButton(
                    text: LocalKeys.next.tr(),
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
        SmoothPageIndicator(
          controller: pageController, // PageController
          count: 3,
          axisDirection: Axis.horizontal,
          effect: const WormEffect(activeDotColor: AppColors.mainColor),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class OnBoardingBodyData {
  final String title, subTitles, image;

  OnBoardingBodyData(
      {required this.title, required this.image, required this.subTitles});
}

List<OnBoardingBodyData> onBoardingData = [
  OnBoardingBodyData(
      title: "${LocalKeys.shopSmarter.tr()},\n${LocalKeys.tradeBetter.tr()}",
      image: AppAssets.blackGirl,
      subTitles: LocalKeys.discoverTopProduct.tr()),
  OnBoardingBodyData(
      title: LocalKeys.securePayment.tr(),
      image: AppAssets.onlinePayment,
      subTitles: LocalKeys.expSeamless.tr()),
  OnBoardingBodyData(
      title: LocalKeys.trackOrder.tr(),
      image: AppAssets.trackOrder,
      subTitles: LocalKeys.stayUpdate.tr()),
];
