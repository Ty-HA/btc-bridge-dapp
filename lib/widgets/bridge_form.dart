import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/wallet_service.dart';

class BridgeForm extends StatefulWidget {
  const BridgeForm({Key? key}) : super(key: key);

  @override
  State<BridgeForm> createState() => _BridgeFormState();
}

class _BridgeFormState extends State<BridgeForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _selectedSourceChain = 'Bitcoin';
  String _selectedTargetChain = 'Ethereum';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Bridge de Tokens',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _ChainSelector(
                label: 'Depuis',
                value: _selectedSourceChain,
                onChanged: (value) {
                  setState(() {
                    _selectedSourceChain = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              _ChainSelector(
                label: 'Vers',
                value: _selectedTargetChain,
                onChanged: (value) {
                  setState(() {
                    _selectedTargetChain = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Montant',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleBridge,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Bridge',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleBridge() {
    if (_formKey.currentState!.validate()) {
      // Logique de bridge à implémenter
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Traitement de la transaction...')),
      );
    }
  }
}

class _ChainSelector extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String?> onChanged;

  const _ChainSelector({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: value,
      items: const [
        DropdownMenuItem(value: 'Bitcoin', child: Text('Bitcoin')),
        DropdownMenuItem(value: 'Ethereum', child: Text('Ethereum')),
        DropdownMenuItem(value: 'Cosmos', child: Text('Cosmos')),
      ],
      onChanged: onChanged,
    );
  }
}