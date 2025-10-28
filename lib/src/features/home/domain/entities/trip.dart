import 'package:equatable/equatable.dart';
import '../enums/trip_status.dart';

class Trip extends Equatable {
  final String id;
  final String status; // Keep as String for JSON serialization
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> participantAvatars;
  final int unfinishedTasks;
  final String coverImage;

  const Trip({
    required this.id,
    required this.status,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.participantAvatars,
    required this.unfinishedTasks,
    required this.coverImage,
  });

  int get nights => endDate.difference(startDate).inDays;
  TripStatus get tripStatus => TripStatus.fromString(status);

  @override
  List<Object?> get props => [
    id,
    status,
    title,
    startDate,
    endDate,
    participantAvatars,
    unfinishedTasks,
    coverImage,
  ];
}
