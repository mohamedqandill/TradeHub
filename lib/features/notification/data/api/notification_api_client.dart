import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import '../models/notification_model.dart';

part 'notification_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class NotificationApiClient {
  @factoryMethod
  factory NotificationApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) = _NotificationApiClient;

  @GET(ApiEndPoints.notifications)
  Future<List<NotificationModel>> getAllNotifications();

  @GET(ApiEndPoints.notificationsUnreadCount)
  Future<int> getUnreadCount();

  @PUT(ApiEndPoints.notificationRead)
  Future<void> markAsRead(@Path("id") int id);
}
