import 'package:flutter/material.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';

class CustomRowText extends StatelessWidget {
  const CustomRowText({super.key, required this.title, required this.price});
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.base.theme.textTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        Text(
          price,
          style: context.base.theme.textTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ],
    );
  }
}
