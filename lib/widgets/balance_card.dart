import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/babylon_bridge_service.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<BabylonBridgeService>(
          builder: (context, service, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Balances',
                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),), 
                const SizedBox(height: 16),
                _BalanceRow(
                  icon: Icons.currency_bitcoin,
                  chain: 'Bitcoin',
                  amount: '${service.btcBalance} BTC',
                ),
                const Divider(height: 24),
                _BalanceRow(
                  icon: Icons.lock_clock,
                  chain: 'Wrapped BTC',
                  amount: '${service.wrappedBalance} wBTC',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  final IconData icon;
  final String chain;
  final String amount;

  const _BalanceRow({
    required this.icon,
    required this.chain,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(width: 12),
        Text(chain),
        const Spacer(),
        Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}