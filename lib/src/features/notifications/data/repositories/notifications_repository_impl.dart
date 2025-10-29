import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_local_ds.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsLocalDataSource local;

  NotificationsRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications() async {
    try {
      final notifications = await local.fetchNotifications();
      return Right(notifications);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
