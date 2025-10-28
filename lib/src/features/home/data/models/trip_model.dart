import '../../domain/entities/trip.dart';
import 'dart:convert';
import '../../../../core/utils/url_utils.dart';

class TripModel {
  final String id;
  final String status;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> participantAvatars;
  final int unfinishedTasks;
  final String coverImage;

  TripModel({
    required this.id,
    required this.status,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.participantAvatars,
    required this.unfinishedTasks,
    required this.coverImage,
  });

  factory TripModel.fromJson(Map<String, dynamic> j) {
    final dates = j['dates'] as Map<String, dynamic>;
    DateTime parseDMY(String s) {
      final p = s.split('-'); // dd-MM-yyyy
      return DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
    }

    final rawParticipants = (j['participants'] as List)
        .cast<Map<String, dynamic>>();
    final participantAvatars = <String>[];
    for (var i = 0; i < rawParticipants.length; i++) {
      final url = rawParticipants[i]['avatar_url'] as String;
      participantAvatars.add(UrlUtils.corsSafe(url, size: 48));
    }

    return TripModel(
      id: j['id'].toString(),
      status: j['status'] as String,
      title: j['title'] as String,
      startDate: parseDMY(dates['start'] as String),
      endDate: parseDMY(dates['end'] as String),
      participantAvatars: participantAvatars,
      unfinishedTasks: (j['unfinished_tasks'] as num).toInt(),
      coverImage: j['cover_image'] as String,
    );
  }

  Trip toEntity() => Trip(
    id: id,
    status: status,
    title: title,
    startDate: startDate,
    endDate: endDate,
    participantAvatars: participantAvatars,
    unfinishedTasks: unfinishedTasks,
    coverImage: coverImage,
  );
}
