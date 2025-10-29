import '../models/notification_model.dart';

abstract class NotificationsLocalDataSource {
  Future<List<NotificationModel>> fetchNotifications();
}

/// Local data source implementation with mock data
class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  @override
  Future<List<NotificationModel>> fetchNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data
    return [
      NotificationModel(
        id: '1',
        title: 'New Trip Added',
        message: 'A new trip to Paris has been added to your schedule.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationModel(
        id: '2',
        title: 'Trip Update',
        message: 'Your upcoming trip to London has been updated.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }
}
