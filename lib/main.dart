import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'src/app.dart';
import 'src/core/di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.initServiceLocator();

  runApp(const ProviderScope(child: App()));
}
