
class Trip {
  final String id;
  final String status;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> participantAvatars;
  final int unfinishedTasks;
  final String coverImage;

  Trip({
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
}
