import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/wallet_service.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<WalletService>(
          builder: (context, wallet, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vos Balances',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _BalanceRow(
                  chain: 'Bitcoin',
                  amount: '0.5 BTC',
                  icon: Icons.currency_bitcoin,
                ),
                const Divider(),
                _BalanceRow(
                  chain: 'Wrapped BTC',
                  amount: '0.3 wBTC',
                  icon: Icons.swap_horiz,
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
  final String chain;
  final String amount;
  final IconData icon;

  const _BalanceRow({
    required this.chain,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            chain,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}