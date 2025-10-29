import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/dimensions.dart';
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
        heightFactor: Dimensions.cardImageHeightFactor,
        widthFactor: 1.0,
        child: Image.network(
          trip.coverImage,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          filterQuality: FilterQuality.medium,
          errorBuilder: (_, __, ___) => const ColoredBox(color: Colors.black26),
        ),
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
        margin: EdgeInsets.all(Dimensions.p16),
        padding: EdgeInsets.all(Dimensions.p8),
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final cardMiddle = height * 0.50;
        final contentStartY =
            height * 0.55; // Start content slightly above middle
        final contentHeight =
            height - contentStartY; // Available height for content

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: cardMiddle,
              left: Dimensions.p14,
              child: StatusChip(status: status, color: _statusColor(status)),
            ),
            Positioned(
              top: contentStartY,
              left: 0,
              right: 0,
              height: contentHeight,
              child: Container(
                padding: EdgeInsets.all(Dimensions.p14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 2),
                    _buildTripTitle(context),
                    const Spacer(flex: 1),
                    _buildDateInfo(context, df),
                    const Spacer(flex: 1),
                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ],
        );
      },
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
          padding: EdgeInsets.only(bottom: Dimensions.p4 / 2),
          child: SvgHelper.asset(Assets.calendar, color: DS.textSecondary),
        ),
        SizedBox(width: Dimensions.p6),
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
        Divider(
          color: Colors.white.withOpacity(Dimensions.overlayOpacity),
          height: Dimensions.dividerHeight,
        ),
        SizedBox(height: Dimensions.p16),
        Row(
          children: [
            Expanded(
              flex: 55,
              child: ParticipantsRow(avatars: trip.participantAvatars),
            ),
            Expanded(
              flex: 45,
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
    final radius = DS.r16;

    // Material handles both shape and clipping -> prevents image bleed on web.
    return Container(
      decoration: BoxDecoration(borderRadius: radius),
      clipBehavior: Clip.antiAliasWithSaveLayer, // <- hard clip
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          // Card background (prevents “see-through” at edges)
          _buildCoverImage(),
          _buildMoreButton(),
          _buildGradientOverlay(),
          _buildCardContent(context),
        ],
      ),
    );
  }
}
