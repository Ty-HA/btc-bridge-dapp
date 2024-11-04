import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/staking_service.dart';

class StakingOverview extends StatelessWidget {
  const StakingOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StakingService>(
      builder: (context, stakingService, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Staking Overview',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  'Total Staked:',
                  '${stakingService.stakedAmount.toStringAsFixed(4)} BTC',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Total Rewards:',
                  '${stakingService.totalRewards.toStringAsFixed(4)} BTC',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Current APY:',
                  '${stakingService.apy.toStringAsFixed(2)}%',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}