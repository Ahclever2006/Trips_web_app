import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/notification.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<AppNotification>>> getNotifications();
}
