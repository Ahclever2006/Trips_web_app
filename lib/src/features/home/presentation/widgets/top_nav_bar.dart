import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/assets.dart';
import '../../../../core/utils/svg_helper.dart';
import '../../../../core/utils/platform_helper.dart';
import 'nav_bar_dimensions.dart';
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
        horizontal: PlatformHelper.isNativeMobile
            ? 0
            : isMobile
            ? NavBarDimensions.mobileHPadding
            : h - NavBarDimensions.mobileHPadding,
        vertical: isMobile
            ? NavBarDimensions.mobileVPadding
            : NavBarDimensions.desktopVPadding,
      ),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onOpenDrawer,
              icon: SvgHelper.asset(Assets.menu),
              tooltip: 'Menu',
            ),

          // logo
          Image.asset(
            Assets.logo,
            width: isMobile
                ? NavBarDimensions.mobileLogoWidth
                : NavBarDimensions.desktopLogoWidth,
            height: isMobile
                ? NavBarDimensions.mobileLogoHeight
                : NavBarDimensions.desktopLogoHeight,
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
                          constraints: BoxConstraints(
                            maxWidth: NavBarDimensions.maxTabsWidth,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: const NavTabs(),
                          ),
                        ),
                      ),

                    if (!isMobile)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: NavBarDimensions.dividerPadding,
                        ),
                        child: VDivider(height: NavBarDimensions.dividerHeight),
                      ),

                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: NavBarDimensions.iconPadding,
                        ),
                        child: SvgHelper.asset(Assets.settings),
                      ),
                      tooltip: 'Settings',
                    ),

                    SizedBox(
                      width: PlatformHelper.isAnyMobile
                          ? NavBarDimensions.iconSpacingMobile
                          : NavBarDimensions.iconSpacingDesktop,
                    ),

                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () =>
                          Navigator.of(context).pushNamed(Routes.notifications),
                      icon: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: NavBarDimensions.iconPadding,
                        ),
                        child: SvgHelper.asset(
                          Assets.notification,
                          color: Colors.white,
                        ),
                      ),
                      tooltip: 'Notifications',
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: PlatformHelper.isAnyMobile
                            ? NavBarDimensions.mobileDividerPadding
                            : NavBarDimensions.dividerPadding,
                      ),
                      child: VDivider(height: NavBarDimensions.dividerHeight),
                    ),

                    CircleAvatar(
                      radius: NavBarDimensions.avatarRadius,
                      backgroundImage: NetworkImage(
                        UrlUtils.corsSafe(
                          'https://randomuser.me/api/portraits/men/88.jpg',
                          size: NavBarDimensions.avatarSize,
                        ),
                      ),
                    ),

                    if (!isMobile) ...[
                      SizedBox(width: NavBarDimensions.nameSpacing),
                      // Let the name shrink instead of pushing overflow
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: NavBarDimensions.maxNameWidth,
                        ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: NavBarDimensions.arrowSpacing,
                        ),
                        child: SvgHelper.asset(Assets.arrowDown),
                      ),
                    ] else
                      SizedBox(width: NavBarDimensions.iconSpacingMobile),
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
