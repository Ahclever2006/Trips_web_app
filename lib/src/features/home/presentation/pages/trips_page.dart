import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/navigation/routes.dart';
import '../viewmodels/trip_list_vm.dart';
import '../viewmodels/nav_tab_vm.dart';
import '../widgets/trip_card.dart';

class TripsPage extends ConsumerStatefulWidget {
  const TripsPage({super.key});
  @override
  ConsumerState<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends ConsumerState<TripsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tripListVMProvider);
    final bp = R.bp(context);
    final isMobile = bp == Breakpoint.mobile;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: DS.bg,
      drawer: isMobile ? const _AppDrawer() : null,
      body: Column(
        children: [
          _TopNavBar(
            isMobile: isMobile,
            onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: R.hPadding(context)),
                child: Column(
                  children: [
                    SizedBox(height: R.topSpacing(context)),
                    // Title row
                    Row(
                      children: [
                        Text(
                          'Items',
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(color: DS.textPrimary),
                        ),
                        const Spacer(),
                        _RoundIconButton(icon: Icons.tune, onPressed: () {}),
                        const SizedBox(width: 12),
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: DS.accent,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 14 : 18,
                              vertical: isMobile ? 10 : 14,
                            ),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(isMobile ? 'Add' : 'Add a New Item'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Grid/List fills the available width (no center constraint)
                    Expanded(
                      child: state.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Failed to load: $e',
                                style: const TextStyle(color: DS.textSecondary),
                              ),
                              const SizedBox(height: 8),
                              FilledButton(
                                onPressed: () => ref
                                    .read(tripListVMProvider.notifier)
                                    .refresh(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                        data: (s) {
                          final cols = R.gridCols(context);
                          if (cols == 1) {
                            return ListView.separated(
                              itemCount: s.visible.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (_, i) => AspectRatio(
                                aspectRatio: 0.95,
                                child: TripCard(trip: s.visible[i]),
                              ),
                            );
                          }
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: cols, // now 5 on very wide
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: R.gridRatio(context),
                                ),
                            itemCount: s.visible.length,
                            itemBuilder: (_, i) => TripCard(trip: s.visible[i]),
                          );
                        },
                      ),
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

/// Header: Desktop/Tablet shows tabs; Mobile shows hamburger + Drawer.
/// Tabs become horizontally scrollable on medium widths to prevent overflow.
// --- Top Nav Bar -------------------------------------------------------------

class _TopNavBar extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onOpenDrawer;
  const _TopNavBar({required this.isMobile, required this.onOpenDrawer});

  @override
  Widget build(BuildContext context) {
    final h = R.hPadding(context);
    final bp = R.bp(context);
    final showTabs = bp != Breakpoint.mobile;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF2A2A2A),
            width: 1,
          ), // grey hairline
        ),
      ),
      padding: EdgeInsets.only(
        left: h,
        right: h,
        top: isMobile ? 8 : 10,
        bottom: 1,
      ),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              onPressed: onOpenDrawer,
              icon: const Icon(Icons.menu, color: Colors.white),
              tooltip: 'Menu',
            ),

          // logo
          Text(
            'logo•',
            style: TextStyle(
              color: DS.accent,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 26,
            ),
          ),

          // push tabs toward the right block (like Figma)
          const Spacer(),

          if (showTabs)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 1,
              ), // sit right above hairline
              child: Align(
                alignment: Alignment.bottomLeft,
                child: const _NavTabs(),
              ),
            ),

          const _VDivider(), // vertical separator

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            tooltip: 'Settings',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.notifications);
            },
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            tooltip: 'Notifications',
          ),

          const _VDivider(),

          const CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5'),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            Text(
              'John Doe',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.white,
            ),
          ],
        ],
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFF2A2A2A),
    );
  }
}

// --- Tabs --------------------------------------------------------------------

class _NavTabs extends ConsumerWidget {
  const _NavTabs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tabs = ['Items', 'Pricing', 'Info', 'Tasks', 'Analytics'];
    final active = ref.watch(activeNavTabProvider);

    return Row(
      mainAxisSize: MainAxisSize.min, // <- avoids expanding left
      children: [
        for (final t in tabs) ...[
          GestureDetector(
            onTap: () => ref.read(activeNavTabProvider.notifier).state = t,
            child: _Tab(label: t, active: t == active),
          ),
          const SizedBox(width: 28),
        ],
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool active;
  const _Tab({required this.label, required this.active});

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

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _RoundIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF2B2B2B),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: DS.textPrimary, size: 18),
        ),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    final itemStyle = Theme.of(
      context,
    ).textTheme.titleMedium!.copyWith(color: DS.textPrimary);
    return Drawer(
      backgroundColor: DS.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'logo•',
                style: TextStyle(
                  color: DS.accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: DS.border),
            ListTile(
              leading: const Icon(
                Icons.inventory_2_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Items', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.attach_money_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Pricing', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: DS.textPrimary),
              title: Text('Info', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.checklist_rtl_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Tasks', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.analytics_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Analytics', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            const Divider(color: DS.border),
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Settings', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
