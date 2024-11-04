import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/bridge_form.dart';
import '../widgets/transaction_history.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Babylon BTC Bridge'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              // TODO: Wallet settings
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              BalanceCard(),
              SizedBox(height: 16),
              BridgeForm(),
              SizedBox(height: 16),
              TransactionHistory(),
            ],
          ),
        ),
      ),
    );
  }
}