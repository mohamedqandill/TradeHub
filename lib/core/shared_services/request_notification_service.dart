import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();

  if (status.isGranted) {
    return;
  } else if (status.isDenied) {
    await Permission.notification.request();
  }
}
