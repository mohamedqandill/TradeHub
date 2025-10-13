import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgWidget extends StatelessWidget {
  const SvgWidget(
      {super.key, required this.assetName, this.fit, this.width, this.height});
  final String assetName;
  final BoxFit? fit;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
