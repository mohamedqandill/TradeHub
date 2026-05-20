import 'package:tradehub/core/api/api_errors/api_error_model.dart';
import 'package:tradehub/features/notification/data/models/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationSuccess(this.notifications);
}

class NotificationError extends NotificationState {
  final ErrorsModel error;
  NotificationError(this.error);
}

class UnreadCountSuccess extends NotificationState {
  final int count;
  UnreadCountSuccess(this.count);
}

class UnreadCountError extends NotificationState {
  final ErrorsModel error;
  UnreadCountError(this.error);
}

class NotificationMarkLoading extends NotificationState {}

class NotificationMarkSuccess extends NotificationState {}

class NotificationMarkError extends NotificationState {
  final ErrorsModel error;
  NotificationMarkError(this.error);
}
