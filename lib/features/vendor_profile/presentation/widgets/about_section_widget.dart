import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/shared_widgets/svg_widget.dart';

import '../../../../core/localization/locale_keys.g.dart';

class AboutSectionWidget extends StatelessWidget {
  const AboutSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        "title": LocaleKeys.storeLocation.tr(),
        "subTitle": """123 Design Avenue, Suite 400
Metropolis, NY 10001""",
        "icon": Assets.icons.address,
      },
      {
        "title": LocaleKeys.contactPhone.tr(),
        "subTitle": "01552191457",
        "icon": Assets.icons.phone,
      },
      {
        "title": LocaleKeys.emailAddress.tr(),
        "subTitle": "mohamedqandill912@gmail.com",
        "icon": Assets.icons.gmail,
      },
      {
        "title": LocaleKeys.overallRating.tr(),
        "subTitle": """4.9 Star Rating based on 1,234
verified reviews""",
        "icon": Assets.icons.star,
      }
    ];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              // height: 350.h,
              decoration: BoxDecoration(
                  color: context.isDarkMode ? AppColors.black : AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.grey, spreadRadius: 1, blurRadius: 8)
                  ]),
              child: Padding(
                padding: EdgeInsets.all(12.0.sp),
                child: Column(
                  children: data.map(
                    (info) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 25.h),
                        child: Row(
                          children: [
                            Container(
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                  color: context.greyOrWhite.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: SvgWidget(
                                assetName: info["icon"],
                                width: 20.w,
                                height: 20.h,
                                fit: BoxFit.scaleDown,
                                color: context.mainColor,
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info["title"],
                                    style: context
                                        .base.theme.textTheme.titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            color: context.isDarkMode
                                                ? AppColors.mainDarkColor
                                                : AppColors.grey),
                                  ),
                                  Text(
                                    info["subTitle"],
                                    style: context
                                        .base.theme.textTheme.titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp,
                                            color: context.isDarkMode
                                                ? AppColors.white
                                                    .withOpacity(0.5)
                                                : AppColors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              LocaleKeys.brandStory.tr(),
              style: context.base.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.mainColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              textAlign: TextAlign.justify,
              """At Moderno Living, we believe that home is more than just a place; it's a feeling. Founded on the principles of timeless design and exceptional craftsmanship, we create furniture that inspires and endures. Each piece is thoughtfully designed in our Metropolis studio and ethically sourced to bring lasting beauty and function to your space.""",
              style: context.base.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: context.greyOrWhite),
            )
          ],
        ),
      ),
    );
  }
}
