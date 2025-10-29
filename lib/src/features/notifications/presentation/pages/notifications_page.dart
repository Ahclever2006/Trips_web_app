import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../viewmodels/notifications_vm.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsVMProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(notificationsVMProvider.notifier).refresh(),
          ),
        ],
      ),
      backgroundColor: DS.bg,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: DS.textSecondary, fontSize: 16),
            ),
          ),
          data: (data) => data.items.isEmpty
              ? const Center(
                  child: Text(
                    'No notifications available',
                    style: TextStyle(color: DS.textSecondary, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: data.items.length,
                  itemBuilder: (context, index) {
                    final notification = data.items[index];
                    return ListTile(
                      title: Text(
                        notification.title,
                        style: const TextStyle(color: DS.textPrimary),
                      ),
                      subtitle: Text(
                        notification.message,
                        style: const TextStyle(color: DS.textSecondary),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
