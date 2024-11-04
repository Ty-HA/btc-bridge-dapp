import 'package:flutter/material.dart';
import '../widgets/staking_overview.dart';
import '../widgets/rewards_chart.dart';
import '../widgets/validator_list.dart';
import '../widgets/performance_metrics.dart';
import 'package:provider/provider.dart';
import '../services/staking_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BTC Staking Monitor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh data
              context.read<StakingService>().refreshData();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<StakingService>().refreshData(),
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StakingOverview(),
              SizedBox(height: 16),
              RewardsChart(),
              SizedBox(height: 16),
              PerformanceMetrics(),
              SizedBox(height: 16),
              ValidatorList(),
            ],
          ),
        ),
      ),
    );
  }
}