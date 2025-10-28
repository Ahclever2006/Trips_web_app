import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/utils/responsive.dart';
import '../viewmodels/trip_list_vm.dart';
import '../widgets/trip_card.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/round_icon_button.dart';
import '../widgets/app_drawer.dart';

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
      drawer: isMobile ? const AppDrawer() : null,
      body: Column(
        children: [
          TopNavBar(
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
                        RoundIconButton(icon: Icons.tune, onPressed: () {}),
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

// The TopNavBar, VDivider, NavTabs/NavTab, RoundIconButton and AppDrawer
// have been moved to separate widget files under
// `lib/src/features/home/presentation/widgets/` to keep this page file small.
