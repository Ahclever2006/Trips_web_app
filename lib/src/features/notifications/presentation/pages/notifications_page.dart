import 'package:flutter/material.dart';
import '../../../../core/design_system/design_tokens.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: DS.bg,
      body: const SafeArea(
        child: Center(
          child: Text(
            'No notifications available',
            style: TextStyle(color: DS.textSecondary, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
