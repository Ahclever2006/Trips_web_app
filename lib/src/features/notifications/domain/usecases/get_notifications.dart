import 'package:dartz/dartz.dart';
import '../entities/notification.dart';
import '../repositories/notifications_repository.dart';
import '../../../../core/domain/usecase.dart';
import '../../../../core/error/failure.dart';

class GetNotifications implements UseCase<List<AppNotification>, NoParams> {
  final NotificationsRepository repository;

  GetNotifications(this.repository);

  @override
  Future<Either<Failure, List<AppNotification>>> call(NoParams params) async {
    return repository.getNotifications();
  }
}
