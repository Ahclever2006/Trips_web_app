import '../entities/notification.dart';

abstract class NotificationsRepository {
  Future<List<AppNotification>> getNotifications();
}
