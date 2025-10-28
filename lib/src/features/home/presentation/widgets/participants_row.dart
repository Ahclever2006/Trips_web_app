import 'package:flutter/material.dart';
import '../../../../core/design_system/design_tokens.dart';

class ParticipantsRow extends StatelessWidget {
  final List<String> avatars;
  static const int _maxToShow = 3;
  static const double _avatarRadius = 16.0;
  static const double _avatarOverlap = 12.0;

  const ParticipantsRow({super.key, required this.avatars});

  @override
  Widget build(BuildContext context) {
    final shown = avatars.take(_maxToShow).toList();
    final extra = avatars.length - shown.length;

    return SizedBox(
      height: _avatarRadius * 2.15,
      child: Stack(
        children: [
          for (int i = 0; i < shown.length; i++)
            Positioned(
              left: i * (_avatarRadius * 2 - _avatarOverlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: DS.border, width: 1.0),
                ),
                child: CircleAvatar(
                  radius: _avatarRadius,
                  backgroundImage: NetworkImage(shown[i]),
                ),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: shown.length * (_avatarRadius * 2 - _avatarOverlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: DS.border, width: 1.0),
                ),
                child: CircleAvatar(
                  radius: _avatarRadius,
                  backgroundColor: Colors.grey.shade700,
                  child: Text(
                    '+$extra',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: DS.accent),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
