import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../../data/repo/notification_repository.dart';
import '../../data/models/notification_model.dart';
import '../state/notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;

  NotificationCubit(this._repository) : super(NotificationInitial());
  List<NotificationModel> notifications = [];
  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    final result = await _repository.getAllNotifications();
    switch (result) {
      case Success():
        notifications = result.data ?? [];
        emit(NotificationSuccess(result.data ?? []));
      case Error():
        emit(NotificationError(result.error!));
    }
  }

  Future<void> fetchUnreadCount() async {
    final result = await _repository.getUnreadCount();
    switch (result) {
      case Success():
        emit(UnreadCountSuccess(result.data ?? 0));
      case Error():
        emit(UnreadCountError(result.error!));
    }
  }

  Future<void> markAsRead(int id) async {
    emit(NotificationMarkLoading());
    final result = await _repository.markAsRead(id);
    switch (result) {
      case Success():
        notifications = notifications
            .map((e) => e.id == id ? e.copyWith(isReadState: true) : e)
            .toList();
        emit(NotificationSuccess(notifications));
      case Error():
        emit(NotificationError(result.error!));
    }
  }

  Future<void> markAllAsRead(List<int> ids) async {
    emit(NotificationMarkLoading());
    final result = await Future.wait(ids.map((e) => _repository.markAsRead(e)));

    switch (result) {
      case Success():
        await fetchNotifications();

      case Error():
        return;
    }
  }
}
