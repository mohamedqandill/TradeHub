import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: ClipOval(
            child: CachedNetworkImage(
          height: 150.h,
          width: 150.w,
          imageUrl: image,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorWidget: (context, url, error) => Center(
              child: Icon(
            Icons.person,
            size: 90.sp,
          )),
        )),
      ),
    );
  }
}
