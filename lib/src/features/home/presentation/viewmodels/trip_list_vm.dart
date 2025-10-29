import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trips_web_app/src/core/di/service_locator.dart';
import '../../domain/entities/trip.dart';
import '../../domain/usecases/get_trips.dart';

class TripListState {
  final List<Trip> items;
  final String? filterStatus;
  const TripListState({this.items = const [], this.filterStatus});

  TripListState copyWith({List<Trip>? items, String? filterStatus}) =>
      TripListState(
        items: items ?? this.items,
        filterStatus: filterStatus ?? this.filterStatus,
      );

  List<Trip> get visible => filterStatus == null
      ? items
      : items
            .where((t) => t.status.toLowerCase() == filterStatus!.toLowerCase())
            .toList();
}

class TripListVM extends AutoDisposeAsyncNotifier<TripListState> {
  late final GetTrips getTrips;

  @override
  Future<TripListState> build() async {
    getTrips = sl<GetTrips>();
    final trips = await getTrips();
    return TripListState(items: trips);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final trips = await getTrips();
      final fs = state.valueOrNull?.filterStatus;
      return TripListState(items: trips, filterStatus: fs);
    });
  }

  void setFilter(String? status) {
    final current = state.valueOrNull ?? const TripListState();
    state = AsyncData(current.copyWith(filterStatus: status));
  }
}

// Provider that uses GetIt service locator
final tripListVMProvider =
    AsyncNotifierProvider.autoDispose<TripListVM, TripListState>(
      TripListVM.new,
    );
