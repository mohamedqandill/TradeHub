import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../../../Core/colors/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/shared_widgets/arrow_back_widget.dart';

class VendorTopSection extends StatelessWidget {
  const VendorTopSection(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.rating,
      required this.reviews});
  final String image;
  final String title;
  final String subTitle;
  final String rating;
  final String reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350.h,
      decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.black.withOpacity(0.2)
              : AppColors.whiteGrey.withOpacity(0.3)),
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Align(
              alignment: context.locale.languageCode == AppConstants.en
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: const ArrowBackWidget()),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: ClipOval(
              child: Image.asset(
                image,
                width: 120.w,
                height: 120.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            title,
            style: context.base.theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            subTitle,
            style: context.base.theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: context.greyOrWhite),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            width: 180.w,
            height: 38.h,
            decoration: BoxDecoration(
                color: context.greyOrWhite.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25.r)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 20.sp,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    rating,
                    style: context.base.theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: context.mainColor),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    reviews,
                    style: context.base.theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: context.greyOrWhite),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
