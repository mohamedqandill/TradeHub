import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../api/notification_api_client.dart';
import '../models/notification_model.dart';
import '../repo/notification_repository.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiClient _apiClient;

  NotificationRepositoryImpl(this._apiClient);

  @override
  Future<ApiResult<List<NotificationModel>>> getAllNotifications() {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.getAllNotifications(),
    );
  }

  @override
  Future<ApiResult<int>> getUnreadCount() {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.getUnreadCount(),
    );
  }

  @override
  Future<ApiResult<void>> markAsRead(int id) {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.markAsRead(id),
    );
  }
}
