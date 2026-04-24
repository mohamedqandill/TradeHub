import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

Widget loadingProductAnimation() {
  return Center(
      child: Lottie.asset("assets/lottie/loadingProductAnimation.json",
          width: 140.w, height: 140.h, fit: BoxFit.cover));
}
