import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/staking_service.dart';

class PerformanceMetrics extends StatelessWidget {
  const PerformanceMetrics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StakingService>(
      builder: (context, stakingService, _) {
        final performance = stakingService.performance;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Performance Metrics',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildMetricTiles(performance),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricTiles(PerformanceData performance) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.5,
      children: [
        _MetricTile(
          title: 'Daily Rewards',
          value: '${performance.dailyReward.toStringAsFixed(6)} BTC',
          icon: Icons.calendar_today,
        ),
        _MetricTile(
          title: 'Weekly Rewards',
          value: '${performance.weeklyReward.toStringAsFixed(6)} BTC',
          icon: Icons.calendar_view_week,
        ),
        _MetricTile(
          title: 'Monthly Rewards',
          value: '${performance.monthlyReward.toStringAsFixed(6)} BTC',
          icon: Icons.calendar_month,
        ),
        _MetricTile(
          title: 'Total Value',
          value: '\$${performance.totalValue.toStringAsFixed(2)}',
          icon: Icons.account_balance_wallet,
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _MetricTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}