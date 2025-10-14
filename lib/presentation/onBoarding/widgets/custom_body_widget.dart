import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base/base_inherited_widgets.dart';

class CustomBodyWidget extends StatefulWidget {
  const CustomBodyWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  State<CustomBodyWidget> createState() => _CustomBodyWidgetState();
}

class _CustomBodyWidgetState extends State<CustomBodyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseInheritedWidget.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 33.h),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: Transform.scale(
                  scale: _scale.value,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX((1 - _scale.value) * 0.8),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.title,
                      style: base.theme.textTheme.headlineLarge,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        FadeTransition(
          opacity: _fade,
          child: Text(
            textAlign: TextAlign.center,
            widget.subTitle,
            style: base.theme.textTheme.headlineMedium,
          ),
        ),
        FadeTransition(
          opacity: _fade,
          child: Image.asset(
            height: 270.h,
            widget.image,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
