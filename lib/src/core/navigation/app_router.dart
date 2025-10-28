import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/trips_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.trips:
        return MaterialPageRoute(
          builder: (_) => const TripsPage(),
          settings: settings,
        );
      case Routes.notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const TripsPage(),
          settings: settings,
        );
    }
  }
}
