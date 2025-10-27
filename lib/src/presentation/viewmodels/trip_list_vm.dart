
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/trip.dart';
import '../../domain/usecases/get_trips.dart';
import '../../data/datasources/trip_local_ds.dart';
import '../../data/repositories/trip_repository_impl.dart';

class TripListState {
  final List<Trip> items;
  final String? filterStatus;
  const TripListState({this.items = const [], this.filterStatus});

  TripListState copyWith({List<Trip>? items, String? filterStatus}) =>
      TripListState(items: items ?? this.items, filterStatus: filterStatus ?? this.filterStatus);

  List<Trip> get visible =>
      filterStatus == null ? items : items.where((t) => t.status.toLowerCase() == filterStatus!.toLowerCase()).toList();
}

class TripListVM extends AsyncNotifier<TripListState> {
  late final GetTrips _getTrips;

  @override
  Future<TripListState> build() async {
    _getTrips = ref.read(getTripsProvider);
    final trips = await _getTrips();
    return TripListState(items: trips);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final trips = await _getTrips();
      final fs = state.valueOrNull?.filterStatus;
      return TripListState(items: trips, filterStatus: fs);
    });
  }

  void setFilter(String? status) {
    final current = state.valueOrNull ?? const TripListState();
    state = AsyncData(current.copyWith(filterStatus: status));
  }
}

// Wiring
final tripLocalDSProvider = Provider((ref) => TripLocalDataSourceImpl());
final tripRepoProvider = Provider((ref) => TripRepositoryImpl(ref.read(tripLocalDSProvider)));
final getTripsProvider = Provider((ref) => GetTrips(ref.read(tripRepoProvider)));
final tripListVMProvider = AsyncNotifierProvider<TripListVM, TripListState>(() => TripListVM());
