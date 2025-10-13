import 'package:flutter/material.dart';

class BaseInheritedWidget extends InheritedWidget {
  final ThemeData theme;
  final double screenWidth, screenHeight;

  BaseInheritedWidget(
      {required this.screenHeight,
      required this.screenWidth,
      required this.theme,
      required super.child});

  static BaseInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BaseInheritedWidget>()
        as BaseInheritedWidget;
  }

  @override
  bool updateShouldNotify(BaseInheritedWidget oldWidget) {
    return oldWidget.theme != theme ||
        oldWidget.screenWidth != screenWidth ||
        oldWidget.screenHeight != screenHeight;
  }
}
