import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trips_web_app/src/core/di/service_locator.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../../../core/domain/usecase.dart';

class NotificationsState {
  final List<AppNotification> items;
  final bool isLoading;
  final String? error;

  const NotificationsState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  NotificationsState copyWith({
    List<AppNotification>? items,
    bool? isLoading,
    String? error,
  }) => NotificationsState(
    items: items ?? this.items,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}

class NotificationsVM extends AutoDisposeAsyncNotifier<NotificationsState> {
  late final GetNotifications getNotifications;

  @override
  Future<NotificationsState> build() async {
    getNotifications = sl<GetNotifications>();
    return _loadNotifications();
  }

  Future<NotificationsState> _loadNotifications() async {
    final result = await getNotifications(NoParams());
    return result.fold(
      (failure) => NotificationsState(error: failure.message),
      (notifications) => NotificationsState(items: notifications),
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadNotifications);
  }
}

// Provider that uses GetIt service locator
final notificationsVMProvider =
    AsyncNotifierProvider.autoDispose<NotificationsVM, NotificationsState>(
      NotificationsVM.new,
    );
