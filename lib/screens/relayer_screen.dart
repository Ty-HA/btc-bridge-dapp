import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/relayer_service.dart';

class RelayerScreen extends StatelessWidget {
  const RelayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staking Relayers'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRelayerStatus(context),
            const SizedBox(height: 16),
            _buildRelayerList(context),
            const SizedBox(height: 16),
            _buildTransactionHistory(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRelayerStatus(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Network Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusIndicator(
                  context,
                  'Active Relayers',
                  '12',
                  Colors.green,
                ),
                _buildStatusIndicator(
                  context,
                  'Network Load',
                  '65%',
                  Colors.orange,
                ),
                _buildStatusIndicator(
                  context,
                  'Response Time',
                  '1.2s',
                  Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildRelayerList(BuildContext context) {
    final relayers = [
      {
        'name': 'Relayer 1',
        'status': 'Active',
        'uptime': '99.9%',
        'fee': '0.1%',
      },
      {
        'name': 'Relayer 2',
        'status': 'Active',
        'uptime': '99.7%',
        'fee': '0.15%',
      },
      {
        'name': 'Relayer 3',
        'status': 'Maintenance',
        'uptime': '98.5%',
        'fee': '0.12%',
      },
    ];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Relayers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton.icon(
                  onPressed: () {
                    // Show relayer selection dialog
                    _showRelayerSelectionDialog(context);
                  },
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Switch Relayer'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...relayers.map((relayer) => _buildRelayerTile(context, relayer)),
          ],
        ),
      ),
    );
  }

  Widget _buildRelayerTile(BuildContext context, Map<String, String> relayer) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: relayer['status'] == 'Active'
              ? Colors.green.withOpacity(0.1)
              : Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          relayer['status'] == 'Active'
              ? Icons.check_circle
              : Icons.warning,
          color: relayer['status'] == 'Active'
              ? Colors.green
              : Colors.orange,
        ),
      ),
      title: Text(relayer['name']!),
      subtitle: Text('Uptime: ${relayer['uptime']}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Fee: ${relayer['fee']}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            relayer['status']!,
            style: TextStyle(
              color: relayer['status'] == 'Active'
                  ? Colors.green
                  : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onTap: () {
        _showRelayerDetails(context, relayer);
      },
    );
  }

  Widget _buildTransactionHistory(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildTransactionTile(
              context,
              'Stake',
              '0.5 BTC',
              DateTime.now().subtract(const Duration(hours: 2)),
              'Completed',
            ),
            const Divider(),
            _buildTransactionTile(
              context,
              'Reward',
              '0.005 BTC',
              DateTime.now().subtract(const Duration(days: 1)),
              'Completed',
            ),
            const Divider(),
            _buildTransactionTile(
              context,
              'Unstake',
              '0.25 BTC',
              DateTime.now().subtract(const Duration(days: 2)),
              'Processing',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(
    BuildContext context,
    String type,
    String amount,
    DateTime time,
    String status,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          type == 'Stake'
              ? Icons.arrow_upward
              : type == 'Unstake'
                  ? Icons.arrow_downward
                  : Icons.star,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(type),
      subtitle: Text(time.toString().substring(0, 16)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: status == 'Completed' ? Colors.green : Colors.orange,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showRelayerSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Relayer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Relayer 1'),
              subtitle: const Text('Fee: 0.1%'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Relayer 2'),
              subtitle: const Text('Fee: 0.15%'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showRelayerDetails(BuildContext context, Map<String, String> relayer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(relayer['name']!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${relayer['status']}'),
            Text('Uptime: ${relayer['uptime']}'),
            Text('Fee: ${relayer['fee']}'),
            const SizedBox(height: 16),
            Text(
              'Performance Metrics',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),), 
            const Text('Average Response Time: 1.2s'),
            const Text('Success Rate: 99.9%'),
            const Text('Daily Transactions: 1,234'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: relayer['status'] == 'Active'
                ? () {
                    // Select this relayer
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('Select Relayer'),
          ),
        ],
      ),
    );
  }
}