import 'package:flutter/material.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../domain/enums/trip_status.dart';

class StatusChip extends StatelessWidget {
  final TripStatus status;
  final Color color;

  const StatusChip({super.key, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: DS.r16,
        border: Border.all(color: color),
      ),
      child: Text(
        status.value,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: DS.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
