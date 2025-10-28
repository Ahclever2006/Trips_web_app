import 'package:flutter/material.dart';
import '../../../../core/design_system/design_tokens.dart';
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
    final bp = R.bp(context);
    final showTabs = bp != Breakpoint.mobile;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF2A2A2A),
            width: 1,
          ), // grey hairline
        ),
      ),
      padding: EdgeInsets.only(top: isMobile ? 8 : 10, bottom: 12.0),
      child: Row(
        children: [
          if (isMobile) ...[
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: IconButton(
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
            ),
            const SizedBox(width: 12),
          ] else
            const SizedBox(width: 80.0),

          // logo
          Image.asset(
            Assets.logo,
            width: isMobile ? 88 : 110,
            height: isMobile ? 28 : 34,
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

          if (!isMobile)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const VDivider(),
            ),

          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SvgHelper.asset(
                Assets.settings,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
            tooltip: 'Settings',
          ),
          SizedBox(width: isMobile ? 12 : 24),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.notifications);
            },
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SvgHelper.asset(
                Assets.notification,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
            tooltip: 'Notifications',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const VDivider(),
          ),

          CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
              UrlUtils.corsSafe(
                'https://randomuser.me/api/portraits/men/88.jpg',
                size: 48,
              ),
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            Text(
              'John Doe',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: Colors.white,
              ),
            ),
          ] else
            const SizedBox(width: 12), // Right padding in mobile
        ],
      ),
    );
  }
}
