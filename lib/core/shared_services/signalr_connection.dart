import 'package:signalr_netcore/signalr_client.dart';
import 'package:tradehub/core/shared_services/local_notifications_service';

class SignalRService {
  // ── Singleton ──────────────────────────────────────────────
  static final SignalRService _instance = SignalRService._internal();
  factory SignalRService() => _instance;
  SignalRService._internal();

  // ── State ──────────────────────────────────────────────────
  HubConnection? _connection;
  String? _lastToken;
  bool _isRunning = false;

  bool get isRunning => _isRunning;

  // ── Public API ─────────────────────────────────────────────
  Future<void> start(String token) async {
    _lastToken = token;

    _connection = HubConnectionBuilder()
        .withUrl(
          "http://tradehub.runasp.net/hubs/notifications",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token,
          ),
        )
        .withAutomaticReconnect()
        .build();

    // listen for notifications
    _connection!.on("ReceiveNotification", (data) {
      final msg = data?.first as Map;
      final title = msg["title"];
      final body = msg["message"];
      LocalNotificationService.showNotification(title: title, body: body);
    });

    await _connection!.start();
    _isRunning = true;
    print("SignalR connected");
  }

  Future<void> stop() async {
    if (_connection != null) {
      await _connection!.stop();
      _isRunning = false;
      print("SignalR stopped");
    }
  }

  /// Re-starts the connection using the last known token (called from settings).
  Future<void> restart() async {
    if (_lastToken != null) {
      await start(_lastToken!);
    }
  }
}
