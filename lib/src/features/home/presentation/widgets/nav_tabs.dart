import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../viewmodels/nav_tab_vm.dart';

class NavTabs extends ConsumerWidget {
  const NavTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tabs = ['Items', 'Pricing', 'Info', 'Tasks', 'Analytics'];
    final active = ref.watch(activeNavTabProvider);

    // Make tabs horizontally scrollable to avoid overflow on narrower widths.
    return SizedBox(
      // fixed height to accommodate text + underline
      height: 44,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min, // <- avoids expanding left
          children: [
            for (final t in tabs) ...[
              GestureDetector(
                onTap: () => ref.read(activeNavTabProvider.notifier).state = t,
                child: NavTab(label: t, active: t == active),
              ),
              const SizedBox(width: 28),
            ],
            // Add a little trailing padding so last tab doesn't butt up against icons
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class NavTab extends StatelessWidget {
  final String label;
  final bool active;
  const NavTab({required this.label, required this.active, super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium!;
    final textStyle = base.copyWith(
      color: active ? Colors.white : const Color(0xFF8F8F8F),
      fontWeight: active ? FontWeight.w600 : FontWeight.w500,
    );

    // Measure the rendered text width so the underline matches it.
    final tp = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textDirection: Directionality.of(context),
    )..layout();

    double underlineWidth = tp.width;
    if (underlineWidth < 8) underlineWidth = 8; // ensure visible min width

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle),
        Transform.translate(
          offset: const Offset(0, 10), // nudge downward
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 3,
            width: active ? underlineWidth : 0,
            decoration: BoxDecoration(
              color: active ? DS.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
