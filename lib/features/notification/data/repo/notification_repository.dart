import 'package:tradehub/core/api/api_result/api_result.dart';
import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<ApiResult<List<NotificationModel>>> getAllNotifications();
  Future<ApiResult<int>> getUnreadCount();
  Future<ApiResult<void>> markAsRead(int id);
}
