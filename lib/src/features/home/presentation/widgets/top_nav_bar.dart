import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/assets.dart';
import '../../../../core/utils/svg_helper.dart';
import 'v_divider.dart';
import 'nav_tabs.dart';

class TopNavBar extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onOpenDrawer;
  const TopNavBar({
    required this.isMobile,
    required this.onOpenDrawer,
    super.key,
  });

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
            color: Color(0xFF262626),
            width: 1,
          ), // grey hairline
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : h - 16.0,
        vertical: isMobile ? 8 : 10,
      ),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onOpenDrawer,
              icon: SvgHelper.asset(
                Assets.menu,
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              tooltip: 'Menu',
            ),

          // logo
          Image.asset(
            Assets.logo,
            width: isMobile ? 88 : 110,
            height: isMobile ? 28 : 34,
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // tabs (also scrollable on medium widths)
                    if (showTabs)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 560),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: const NavTabs(),
                          ),
                        ),
                      ),

                    if (!isMobile)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: VDivider(),
                      ),

                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SvgHelper.asset(
                          Assets.settings,

                          color: Colors.white,
                        ),
                      ),
                      tooltip: 'Settings',
                    ),

                    SizedBox(width: isMobile ? 12 : 24),

                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () =>
                          Navigator.of(context).pushNamed(Routes.notifications),
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SvgHelper.asset(
                          Assets.notification,

                          color: Colors.white,
                        ),
                      ),
                      tooltip: 'Notifications',
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: VDivider(),
                    ),

                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        UrlUtils.corsSafe(
                          'https://randomuser.me/api/portraits/men/88.jpg',
                          size: 48,
                        ),
                      ),
                    ),

                    if (!isMobile) ...[
                      const SizedBox(width: 16.0),
                      // Let the name shrink instead of pushing overflow
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: Text(
                          'John Doe',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgHelper.asset(Assets.arrowDown),
                      ),
                    ] else
                      const SizedBox(width: 12),
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
