
import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetTrips {
  final TripRepository repo;
  GetTrips(this.repo);
  Future<List<Trip>> call() => repo.getTrips();
}
