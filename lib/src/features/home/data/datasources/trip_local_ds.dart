import '../../../../core/utils/asset_loader.dart';
import '../models/trip_model.dart';

abstract class TripLocalDataSource {
  Future<List<TripModel>> getTrips();
}

class TripLocalDataSourceImpl implements TripLocalDataSource {
  final String assetPath;
  TripLocalDataSourceImpl({this.assetPath = 'assets/data/trips_mock.json'});

  @override
  Future<List<TripModel>> getTrips() async {
    final data = await AssetLoader.json(assetPath);
    final list = (data['trips'] as List).cast<Map<String, dynamic>>();
    return list.map(TripModel.fromJson).toList();
  }
}
