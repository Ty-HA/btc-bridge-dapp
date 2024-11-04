import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/staking_service.dart';
import '../services/babylon_bridge_service.dart';
import '../screens/relayer_screen.dart';

class StakingScreen extends StatelessWidget {
  const StakingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stakingService = Provider.of<StakingService>(context);
    final babylonService = Provider.of<BabylonBridgeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BTC Staking',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),),
        
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RelayerScreen(),
                ),
              );
            },
            tooltip: 'Manage Relayers',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await stakingService.refreshData();
          await babylonService.refreshBalances();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBalanceCard(context),
                const SizedBox(height: 16),
                _buildStakingOptions(context),
                const SizedBox(height: 16),
                _buildRewardsCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
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
                  'Total Balance',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    Provider.of<BabylonBridgeService>(context, listen: false)
                        .refreshBalances();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<BabylonBridgeService>(
              builder: (context, service, _) => Text(
                '${service.btcBalance} BTC',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Consumer<BabylonBridgeService>(
              builder: (context, service, _) => Text(
                '\$${(service.btcBalance * 35000).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStakingOptions(BuildContext context) {
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
              'Staking Options',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),), 
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lock_clock,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              title: const Text('Flexible Staking'),
              subtitle: const Text('APY: 4.5%'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Show flexible staking dialog
                  _showStakingDialog(context, true);
                },
                child: const Text('Stake'),
              ),
            ),
            const Divider(),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.sync, color: Colors.green),
              ),
              title: const Text('Current Relayer'),
              subtitle: const Text('Relayer 1 - Fee: 0.1%'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RelayerScreen(),
                    ),
                  );
                },
                child: const Text('Change'),
              ),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              title: const Text('Locked Staking'),
              subtitle: const Text('APY: 6.5%'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Show locked staking dialog
                  _showStakingDialog(context, false);
                },
                child: const Text('Stake'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsCard(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Consumer<StakingService>(
        builder: (context, stakingService, _) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Rewards',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),), 
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRewardInfo(
                    context,
                    'Total Earned',
                    '${stakingService.totalRewards} BTC',
                    '\$${(stakingService.totalRewards * 35000).toStringAsFixed(2)}',
                  ),
                  _buildRewardInfo(
                    context,
                    'Pending Rewards',
                    '0.0023 BTC',
                    '\$80.50',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: stakingService.totalRewards > 0
                      ? () {
                          // Handle claiming rewards
                          _handleClaimRewards(context);
                        }
                      : null,
                  icon: const Icon(Icons.redeem),
                  label: const Text('Claim Rewards'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardInfo(
    BuildContext context,
    String title,
    String amount,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  void _showStakingDialog(BuildContext context, bool isFlexible) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isFlexible ? 'Flexible Staking' : 'Locked Staking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (BTC)',
                hintText: 'Enter amount to stake',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'APY: ${isFlexible ? '4.5' : '6.5'}%',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (!isFlexible) ...[
              const SizedBox(height: 8),
              const Text('Lock period: 90 days'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle staking
              Navigator.pop(context);
            },
            child: const Text('Stake'),
          ),
        ],
      ),
    );
  }

  void _handleClaimRewards(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Claim Rewards'),
        content: const Text('Do you want to claim your rewards now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle claiming rewards
              Navigator.pop(context);
            },
            child: const Text('Claim'),
          ),
        ],
      ),
    );
  }
}
