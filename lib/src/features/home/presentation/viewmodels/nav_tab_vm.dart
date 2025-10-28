import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Holds the active navigation tab label for the top nav.
final activeNavTabProvider = StateProvider<String>((_) => 'Items');
