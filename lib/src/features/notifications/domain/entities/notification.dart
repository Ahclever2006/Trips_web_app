import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    String? message,
    DateTime? timestamp,
    this.isRead = false,
  }) : message = message ?? title,
       timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [id, title, message, timestamp, isRead];
}
