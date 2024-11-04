import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/staking_service.dart';

class ValidatorList extends StatelessWidget {
  const ValidatorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StakingService>(
      builder: (context, stakingService, _) {
        final validators = stakingService.validators;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Validators',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: validators.length,
                  itemBuilder: (context, index) {
                    final validator = validators[index];
                    return Card(
                      child: ListTile(
                        title: Text(validator.name),
                        subtitle: Text(
                          'Address: ${validator.address}\n'
                          'Staked: ${validator.stakedAmount.toStringAsFixed(4)} BTC',
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Uptime: ${validator.uptime.toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Commission: ${validator.commission.toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}