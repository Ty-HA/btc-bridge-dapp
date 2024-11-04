import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/staking_service.dart';
import '../services/babylon_bridge_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Color(0xFFFF761B),
              ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Account',
            [
              _buildSettingTile(
                context,
                'Profile',
                Icons.person_outline,
                () {},
              ),
              _buildSettingTile(
                context,
                'Security',
                Icons.security,
                () {},
              ),
              _buildSettingTile(
                context,
                'Notifications',
                Icons.notifications_outlined,
                () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            'Preferences',
            [
              _buildSettingTile(
                context,
                'Theme',
                Icons.palette_outlined,
                () {},
              ),
              _buildSettingTile(
                context,
                'Language',
                Icons.language,
                () {},
              ),
              _buildSettingTile(
                context,
                'Currency',
                Icons.attach_money,
                () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            'Support',
            [
              _buildSettingTile(
                context,
                'Help Center',
                Icons.help_outline,
                () {},
              ),
              _buildSettingTile(
                context,
                'Contact Us',
                Icons.mail_outline,
                () {},
              ),
              _buildSettingTile(
                context,
                'About',
                Icons.info_outline,
                () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Handle logout
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
