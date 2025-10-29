import 'package:get_it/get_it.dart';
import '../../features/home/data/datasources/trip_local_ds.dart';
import '../../features/home/data/repositories/trip_repository_impl.dart';
import '../../features/home/domain/repositories/trip_repository.dart';
import '../../features/home/domain/usecases/get_trips.dart';
import '../../features/notifications/data/datasources/notifications_local_ds.dart';
import '../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/notifications/domain/usecases/get_notifications.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Features
  _initTripsFeature();
  _initNotificationsFeature();
}

void _initTripsFeature() {
  // Data Sources
  sl.registerLazySingleton<TripLocalDataSource>(
    () => TripLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<TripRepository>(() => TripRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetTrips(sl()));
}

void _initNotificationsFeature() {
  // Data Sources
  sl.registerLazySingleton<NotificationsLocalDataSource>(
    () => NotificationsLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(local: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetNotifications(sl()));
}
