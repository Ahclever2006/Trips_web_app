import 'package:flutter/material.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/navigation/routes.dart';
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
                child: const NavTabs(),
              ),
            ),

          const VDivider(), // vertical separator

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

          const VDivider(),

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
