
import 'package:flutter/material.dart';
import '../core/design_system/design_tokens.dart';
import '../core/design_system/text_styles.dart';
import 'pages/trips_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        surface: DS.surface,
        primary: DS.accent,
        background: DS.bg,
      ),
      scaffoldBackgroundColor: DS.bg,
      textTheme: DSText.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: DS.bg,
        surfaceTintColor: Colors.transparent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );

    return MaterialApp(
      title: 'Trips',
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(data: media.copyWith(textScaler: const TextScaler.linear(1.0)), child: child!);
      },
      home: const TripsPage(),
    );
  }
}
