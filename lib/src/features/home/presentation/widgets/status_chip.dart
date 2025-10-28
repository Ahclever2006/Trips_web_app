import 'package:flutter/material.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/dimensions.dart';
import '../../domain/enums/trip_status.dart';

class StatusChip extends StatelessWidget {
  final TripStatus status;
  final Color color;

  const StatusChip({super.key, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.p16,
        vertical: Dimensions.p4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(Dimensions.chipOpacity),
        borderRadius: BorderRadius.circular(Dimensions.cardCornerRadius),
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
