import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_local_ds.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsLocalDataSource local;

  NotificationsRepositoryImpl({required this.local});

  @override
  Future<List<AppNotification>> getNotifications() =>
      local.fetchNotifications();
}
