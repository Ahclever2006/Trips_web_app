import 'package:flutter/material.dart';
import '../../../../core/assets.dart';
import '../../../../core/design_system/design_tokens.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final itemStyle = Theme.of(
      context,
    ).textTheme.titleMedium!.copyWith(color: DS.textPrimary);
    return Drawer(
      backgroundColor: DS.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Image.asset(Assets.logo, width: 88, height: 28),
            const SizedBox(height: 16),
            const Divider(color: DS.border),
            ListTile(
              leading: const Icon(
                Icons.inventory_2_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Items', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.attach_money_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Pricing', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: DS.textPrimary),
              title: Text('Info', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.checklist_rtl_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Tasks', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.analytics_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Analytics', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            const Divider(color: DS.border),
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                color: DS.textPrimary,
              ),
              title: Text('Settings', style: itemStyle),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
