import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/design_system/design_tokens.dart';
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
          // Background image
          Positioned.fill(
            child: Image.network(trip.coverImage, fit: BoxFit.cover),
          ),
          // Gradient overlay (much stronger and higher up)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFF171717)],
                  stops: [0.10, 0.55],
                ),
              ),
            ),
          ),

          // Foreground content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusChip(
                    label: trip.status,
                    color: _statusColor(trip.status),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    trip.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${trip.nights} Nights (${df.format(trip.startDate)} - ${df.format(trip.endDate)})',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Divider(color: Colors.white.withOpacity(0.25), height: 0.5),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      _ParticipantsRow(avatars: trip.participantAvatars),
                      const Spacer(),
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

          // Ellipsis button (top-right)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 20,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: DS.r16,
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ParticipantsRow extends StatelessWidget {
  final List<String> avatars;
  final int maxToShow;
  const _ParticipantsRow({required this.avatars, this.maxToShow = 3});

  @override
  Widget build(BuildContext context) {
    final shown = avatars.take(maxToShow).toList();
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
                ).textTheme.labelSmall?.copyWith(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
