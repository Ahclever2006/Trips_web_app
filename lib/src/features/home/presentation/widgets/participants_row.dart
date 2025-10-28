import 'package:flutter/material.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/dimensions.dart';

class ParticipantsRow extends StatelessWidget {
  final List<String> avatars;
  static const int _maxToShow = 3;

  const ParticipantsRow({super.key, required this.avatars});

  @override
  Widget build(BuildContext context) {
    final shown = avatars.take(_maxToShow).toList();
    final extra = avatars.length - shown.length;

    return SizedBox(
      height: Dimensions.avatarRadius * 3,
      child: Stack(
        children: [
          for (int i = 0; i < shown.length; i++)
            Positioned(
              left:
                  i * (Dimensions.avatarRadius * 2 - Dimensions.avatarOverlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: DS.border,
                    width: Dimensions.avatarBorderWidth,
                  ),
                ),
                child: CircleAvatar(
                  radius: Dimensions.avatarRadius,
                  backgroundImage: NetworkImage(shown[i]),
                ),
              ),
            ),
          if (extra > 0)
            Positioned(
              left:
                  shown.length *
                  (Dimensions.avatarRadius * 2 - Dimensions.avatarOverlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: DS.border,
                    width: Dimensions.avatarBorderWidth,
                  ),
                ),
                child: CircleAvatar(
                  radius: Dimensions.avatarRadius,
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
