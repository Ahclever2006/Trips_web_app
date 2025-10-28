import '../../domain/entities/notification.dart';

/// Dummy local data source for notifications.
class NotificationsLocalDataSource {
  Future<List<AppNotification>> fetchNotifications() async {
    // Dummy empty list for now
    return [];
  }
}
