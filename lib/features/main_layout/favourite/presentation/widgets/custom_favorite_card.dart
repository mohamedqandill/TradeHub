import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../../../../core/assets/assets.gen.dart';

class CustomFavoriteCard extends StatefulWidget {
  const CustomFavoriteCard(
      {super.key,
      required this.image,
      required this.title,
      required this.storeName,
      required this.price});
  final String image;
  final String title;
  final String storeName;
  final String price;

  @override
  State<CustomFavoriteCard> createState() => _CustomFavoriteCardState();
}

class _CustomFavoriteCardState extends State<CustomFavoriteCard> {
  bool isHeartTapped = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.black : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            )
          ],
          // border: Border.all(width: 1, color: AppColors.white.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(15.r)),
      child: Row(
        children: [
          // SizedBox(
          //   width: 10.w,
          // ),
          Image.asset(
            widget.image,
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
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
                Text(
                  widget.storeName,
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                    color: context.mainColor.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  "${widget.price}EG",
                  style: context.base.theme.textTheme.bodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 15.sp),
                )
              ],
            ),
          ),
          // Container(
          //   width: 50,
          //   height: 50,
          //   decoration:
          //       BoxDecoration(shape: BoxShape.circle, color: context.mainColor),
          //   child: const Icon(
          //     Icons.shopping_cart,
          //     color: AppColors.white,
          //   ),
          // ),
          InkWell(
            onTap: () {
              setState(() {
                isHeartTapped = !isHeartTapped;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                isHeartTapped
                    ? Assets.icons.heartFilled.path
                    : Assets.icons.heart.path,
                width: 38,
                height: 38,
                fit: BoxFit.fill,
                color: isHeartTapped ? Colors.red : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
