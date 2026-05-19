import 'package:signalr_netcore/signalr_client.dart';
import 'package:tradehub/core/shared_services/local_notifications_service';

class SignalRService {
  late HubConnection connection;

  Future<void> start(String token) async {
    connection = HubConnectionBuilder()
        .withUrl(
          "http://tradehub.runasp.net/hubs/notifications",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token,
          ),
        )
        .withAutomaticReconnect()
        .build();

    print("connected");

    // listen for notifications
    connection.on("ReceiveNotification", (data) {
      final msg = data?.first as Map;

      final title = msg["title"];
      final body = msg["message"];

      LocalNotificationService.showNotification(
        title: title,
        body: body,
      );
    });

    await connection.start();
  }

  Future<void> stop() async {
    await connection.stop();
  }
}
