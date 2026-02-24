import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

class DevicePreviewWidget extends StatelessWidget {
  const DevicePreviewWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      builder: (context) {
        return child;
      },
    );
  }
}
