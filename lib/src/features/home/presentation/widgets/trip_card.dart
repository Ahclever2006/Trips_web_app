import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/assets.dart';
import '../../../../core/utils/svg_helper.dart';
import '../../domain/entities/trip.dart';
import '../../domain/enums/trip_status.dart';
import 'participants_row.dart';
import 'status_chip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  const TripCard({super.key, required this.trip});

  Color _statusColor(TripStatus status) {
    switch (status) {
      case TripStatus.pending:
        return DS.statusPending;
      case TripStatus.proposal:
        return DS.statusProposal;
      case TripStatus.ready:
        return DS.statusReady;
    }
  }

  Widget _buildCoverImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: FractionallySizedBox(
        heightFactor: 0.60,
        widthFactor: 1.0,
        child: Image.network(trip.coverImage, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildMoreButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(8.0),
        child: SvgHelper.asset(Assets.more),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(gradient: DS.tripCardGradient),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    final df = DateFormat('MMM d, yyyy');
    final status = trip.tripStatus;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusChip(status: status, color: _statusColor(status)),
            const SizedBox(height: 32.0),
            _buildTripTitle(context),
            const SizedBox(height: 12.0),
            _buildDateInfo(context, df),
            const SizedBox(height: 16.0),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTripTitle(BuildContext context) {
    return Text(
      trip.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(color: Colors.white),
    );
  }

  Widget _buildDateInfo(BuildContext context, DateFormat df) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: SvgHelper.asset(Assets.calendar, color: DS.textSecondary),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            '${trip.nights} Nights (${df.format(trip.startDate)} - ${df.format(trip.endDate)})',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: Colors.white.withOpacity(0.25), height: 1.0),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: ParticipantsRow(avatars: trip.participantAvatars),
            ),
            Expanded(
              flex: 4,
              child: Text(
                '${trip.unfinishedTasks} unfinished tasks',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: Colors.white70),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: DS.r16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildCoverImage(),
          _buildMoreButton(),
          _buildGradientOverlay(),
          _buildCardContent(context),
        ],
      ),
    );
  }
}
