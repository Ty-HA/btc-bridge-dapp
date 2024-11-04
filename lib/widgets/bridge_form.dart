import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/babylon_bridge_service.dart';

class BridgeForm extends StatefulWidget {
  const BridgeForm({Key? key}) : super(key: key);

  @override
  State<BridgeForm> createState() => _BridgeFormState();
}

class _BridgeFormState extends State<BridgeForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isBridgingToBabylon = true;
  bool _useDefaultAddress = true;

  @override
  void dispose() {
    _amountController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = context.watch<BabylonBridgeService>();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Bridge Bitcoin',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _DirectionButton(
                      isSelected: _isBridgingToBabylon,
                      onTap: () => setState(() => _isBridgingToBabylon = true),
                      title: 'BTC → Babylon',
                      subtitle: 'Lock BTC',
                      icon: Icons.lock,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DirectionButton(
                      isSelected: !_isBridgingToBabylon,
                      onTap: () => setState(() => _isBridgingToBabylon = false),
                      title: 'Babylon → BTC',
                      subtitle: 'Unlock BTC',
                      icon: Icons.lock_open,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  suffixText: 'BTC',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  if (_isBridgingToBabylon && amount > service.btcBalance) {
                    return 'Insufficient BTC balance';
                  }
                  if (!_isBridgingToBabylon && amount > service.wrappedBalance) {
                    return 'Insufficient wrapped BTC balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _useDefaultAddress,
                onChanged: (value) => setState(() => _useDefaultAddress = value!),
                title: const Text('Use default address'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              if (!_useDefaultAddress) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: _isBridgingToBabylon 
                      ? 'Babylon Address'
                      : 'Bitcoin Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (!_useDefaultAddress && (value == null || value.isEmpty)) {
                      return 'Please enter a destination address';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleBridge,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _isBridgingToBabylon ? 'Bridge to Babylon' : 'Bridge to Bitcoin',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleBridge() async {
    if (_formKey.currentState!.validate()) {
      final service = context.read<BabylonBridgeService>();
      final amount = double.parse(_amountController.text);
      final destinationAddress = _useDefaultAddress ? null : _addressController.text;
      
      try {
        final txHash = _isBridgingToBabylon
            ? await service.bridgeToBabylon(
                amount: amount,
                destinationAddress: destinationAddress,
              )
            : await service.bridgeFromBabylon(
                amount: amount,
                destinationAddress: destinationAddress,
              );
            
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transaction submitted: $txHash')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }
}

class _DirectionButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final IconData icon;

  const _DirectionButton({
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}