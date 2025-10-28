import 'package:flutter/widgets.dart';

/// Breakpoints tuned for the Figma layout:
/// - >= 1600 : 5 cards (large desktop)
/// - >= 1200 : 4 cards (desktop)
/// - >= 900  : 3 cards (small desktop / large tablet landscape)
/// - >= 700  : 2 cards (tablet)
/// - else    : 1 card  (mobile)
enum Breakpoint { mobile, tablet, smDesktop, desktop, lgDesktop }

class R {
  static Breakpoint bp(BuildContext c) {
    final w = MediaQuery.of(c).size.width;
    if (w >= 1600) return Breakpoint.lgDesktop;
    if (w >= 1200) return Breakpoint.desktop;
    if (w >= 900) return Breakpoint.smDesktop;
    if (w >= 700) return Breakpoint.tablet;
    return Breakpoint.mobile;
  }

  static int gridCols(BuildContext c) {
    switch (bp(c)) {
      case Breakpoint.lgDesktop:
        return 5;
      case Breakpoint.desktop:
        return 4;
      case Breakpoint.smDesktop:
        return 3;
      case Breakpoint.tablet:
        return 2;
      case Breakpoint.mobile:
        return 1;
    }
  }

  static double gridRatio(BuildContext c) {
    switch (bp(c)) {
      case Breakpoint.lgDesktop:
        return 0.75;
      case Breakpoint.desktop:
        return 0.75;
      case Breakpoint.smDesktop:
        return 0.75;
      case Breakpoint.tablet:
        return 0.75;
      case Breakpoint.mobile:
        return 0.75;
    }
  }

  static double tripCardHeightFactor(BuildContext c) {
    switch (bp(c)) {
      case Breakpoint.lgDesktop:
        return 0.60;
      case Breakpoint.desktop:
        return 0.63;
      case Breakpoint.smDesktop:
        return 0.66;
      case Breakpoint.tablet:
        return 0.69;
      case Breakpoint.mobile:
        return 0.55;
    }
  }

  /// Horizontal padding that scales a bit with width to avoid huge gutters.
  static double hPadding(BuildContext c) {
    final w = MediaQuery.of(c).size.width;
    if (w >= 1600) return 80.0;
    if (w >= 1200) return 80.0;
    if (w >= 900) return 80.0;
    if (w >= 700) return 80.0;
    return 16;
  }

  /// Vertical spacing above the grid.
  static double topSpacing(BuildContext c) {
    return bp(c) == Breakpoint.mobile ? 16 : 20;
  }
}
