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
        title: Text('BTC Staking Monitor',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),),  
        actions: [
          // Refresh Button
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Data',
            onPressed: () {
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