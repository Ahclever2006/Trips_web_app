import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/assets.dart';
import '../../../../core/utils/svg_helper.dart';
import '../../domain/entities/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  const TripCard({super.key, required this.trip});

  Color _statusColor(String s) {
    final v = s.toLowerCase();
    if (v.contains('pending')) return DS.statusPending;
    if (v.contains('proposal')) return DS.statusProposal;
    if (v.contains('ready')) return DS.statusReady;
    return DS.statusProposal;
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('MMM d, yyyy');

    return ClipRRect(
      borderRadius: DS.r16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image occupies top 60% of the card
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.60,
              widthFactor: 1.0,
              child: Image.network(trip.coverImage, fit: BoxFit.cover),
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          // Gradient overlay (your current look, don't change)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: DS.tripCardGradient),
            ),
          ),

          // Foreground content — spaced to match design
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.56,
              widthFactor: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatusChip(
                      label: trip.status,
                      color: _statusColor(trip.status),
                    ),
                    const SizedBox(height: 16.0),

                    Text(
                      trip.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    Row(
                      children: [
                        SvgHelper.asset(
                          Assets.calendar,
                          width: 14,
                          height: 14,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${trip.nights} Nights (${df.format(trip.startDate)} - ${df.format(trip.endDate)})',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Divider + participants row pinned to bottom
                    Divider(color: Colors.white.withOpacity(0.25), height: 0.5),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ParticipantsRow(avatars: trip.participantAvatars),
                        Text(
                          '${trip.unfinishedTasks} unfinished tasks',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: DS.r16,
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: DS.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ParticipantsRow extends StatelessWidget {
  final List<String> avatars;
  static const int _maxToShow =
      3; // Fixed value since it's not configurable in our UI

  const _ParticipantsRow({required this.avatars});

  @override
  Widget build(BuildContext context) {
    final shown = avatars.take(_maxToShow).toList();
    final extra = avatars.length - shown.length;
    return Row(
      children: [
        for (int i = 0; i < shown.length; i++)
          Transform.translate(
            offset: Offset(i * -6, 0),
            child: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(shown[i]),
            ),
          ),
        if (extra > 0)
          Transform.translate(
            offset: Offset(shown.length * -6.0, 0),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade700,
              child: Text(
                '+$extra',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: DS.accent),
              ),
            ),
          ),
      ],
    );
  }
}
