// lib/screens/bridge_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/babylon_bridge_service.dart';
import '../widgets/bridge_form.dart';
import '../widgets/transaction_history.dart';

class BridgeScreen extends StatelessWidget {
  const BridgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bridgeService = context.watch<BabylonBridgeService>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Babylon Bridge', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              bridgeService.refreshBalances();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => bridgeService.refreshBalances(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                        AppBar().preferredSize.height - 
                        MediaQuery.of(context).padding.top - 
                        32, // Pour le padding vertical total
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Balance Overview
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Balances',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color(0xFFFF761B),
                      ),), 
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _BalanceCard(
                                title: 'Bitcoin',
                                amount: bridgeService.btcBalance,
                                symbol: 'BTC',
                                icon: Icons.currency_bitcoin,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _BalanceCard(
                                title: 'Wrapped BTC',
                                amount: bridgeService.wrappedBalance,
                                symbol: 'wBTC',
                                icon: Icons.token,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const BridgeForm(),
                const SizedBox(height: 16),
                const TransactionHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String title;
  final double amount;
  final String symbol;
  final IconData icon;

  const _BalanceCard({
    required this.title,
    required this.amount,
    required this.symbol,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),  // Réduit le padding
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  // Pour minimiser la hauteur
        children: [
          Row(
            children: [
              Icon(icon, size: 16),  // Icône plus petite
              const SizedBox(width: 4),  // Espacement réduit
              Expanded(  // Pour éviter le débordement du texte
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),  // Espacement réduit
          Text(
            '$amount $symbol',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}