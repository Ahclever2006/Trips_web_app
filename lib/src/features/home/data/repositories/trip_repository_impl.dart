
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_local_ds.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource local;
  TripRepositoryImpl(this.local);

  @override
  Future<List<Trip>> getTrips() async {
    final models = await local.getTrips();
    return models.map((m) => m.toEntity()).toList();
  }
}
