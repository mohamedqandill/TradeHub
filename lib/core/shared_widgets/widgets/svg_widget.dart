import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatelessWidget {
  const SvgWidget({
    super.key,
    required this.assetName,
    this.fit,
    this.width,
    this.height,
    this.color,
  });

  final String assetName;
  final BoxFit? fit;
  final double? width, height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      colorFilter:
          color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}
