import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/babylon_bridge_service.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction History',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<BridgeTransaction>>(
              future: context.read<BabylonBridgeService>().getTransactionHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No transactions yet'),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final tx = snapshot.data![index];
                    return ListTile(
                      leading: Icon(
                        tx.direction == BridgeDirection.toBabylon
                            ? Icons.arrow_forward
                            : Icons.arrow_back,
                        color: tx.status == TransactionStatus.completed
                            ? Colors.green
                            : Colors.orange,
                      ),
                      title: Text('${tx.amount} BTC'),
                      subtitle: Text(
                        tx.direction == BridgeDirection.toBabylon
                            ? 'To Babylon'
                            : 'To Bitcoin',
                      ),
                      trailing: Text(
                        tx.status == TransactionStatus.completed
                            ? 'Completed'
                            : 'Pending',
                        style: TextStyle(
                          color: tx.status == TransactionStatus.completed
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}