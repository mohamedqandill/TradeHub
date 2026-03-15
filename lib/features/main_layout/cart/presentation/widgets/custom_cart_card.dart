import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../../../../Core/colors/app_colors.dart';

class CustomCartCard extends StatefulWidget {
  const CustomCartCard(
      {super.key,
      required this.image,
      required this.title,
      this.size,
      required this.price,
      this.color});
  final String image;
  final String title;
  final String? size;
  final String? color;
  final String price;

  @override
  State<CustomCartCard> createState() => _CustomCartCardState();
}

class _CustomCartCardState extends State<CustomCartCard> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Image.asset(
            widget.image,
            width: 110.w,
            height: 110.h,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: context.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    widget.size != null
                        ? Text(
                            "SIZE: ${widget.size}",
                            style: context.base.theme.textTheme.bodyMedium
                                ?.copyWith(
                              fontSize: 13.sp,
                              color: context.greyOrWhite,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: 5.w,
                    ),
                    widget.color != null
                        ? Text(
                            "COLOR: ${widget.color}",
                            style: context.base.theme.textTheme.bodyMedium
                                ?.copyWith(
                              fontSize: 13.sp,
                              color: context.greyOrWhite,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding: context.locale.languageCode == AppConstants.ar
                      ? EdgeInsets.only(left: 10.w)
                      : EdgeInsets.only(right: 10.w),
                  child: Row(
                    children: [
                      Text(
                        "${widget.price} EGP",
                        style: context.base.theme.textTheme.bodyMedium
                            ?.copyWith(
                                color: context.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontSize: 13.sp),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          if (count > 1) {
                            count--;
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(
                                  color: AppColors.grey.withOpacity(0.5),
                                  width: 1),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.remove,
                            size: 17.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          count.toString(),
                          style: context.base.theme.textTheme.bodyMedium
                              ?.copyWith(
                                  color: context.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 15.sp),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            count++;
                          });
                        },
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              color: context.mainColor, shape: BoxShape.circle),
                          child: Icon(
                            Icons.add,
                            size: 17.sp,
                            color: context.isDarkMode
                                ? AppColors.black
                                : AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
