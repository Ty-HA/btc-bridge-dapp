// lib/services/babylon_bridge_service.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum BridgeDirection { toBabylon, toBitcoin }
enum TransactionStatus { pending, completed, failed }

class BridgeTransaction {
  final String hash;
  final double amount;
  final String sourceAddress;
  final String destinationAddress;
  final BridgeDirection direction;
  final TransactionStatus status;
  final DateTime timestamp;

  BridgeTransaction({
    required this.hash,
    required this.amount,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.direction,
    required this.status,
    required this.timestamp,
  });
}

class BabylonBridgeService extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  
  String? _btcAddress;
  String? _babylonAddress;
  double _btcBalance = 0;
  double _wrappedBalance = 0;
  final List<BridgeTransaction> _transactions = [];

  String get btcAddress => _btcAddress ?? '';
  String get babylonAddress => _babylonAddress ?? '';
  double get btcBalance => _btcBalance;
  double get wrappedBalance => _wrappedBalance;

  Future<void> initialize() async {
    try {
      _btcAddress = await _storage.read(key: 'btc_address');
      _babylonAddress = await _storage.read(key: 'babylon_address');
      
      if (_btcAddress != null) {
        await refreshBalances();
      }
    } catch (e) {
      debugPrint('Erreur lors de l\'initialisation: $e');
      rethrow;
    }
  }

  Future<void> createWallet() async {
    try {
      // Simulé pour l'exemple
      _btcAddress = 'bc1_test_address';
      _babylonAddress = 'babylon_test_address';

      await _storage.write(key: 'btc_address', value: _btcAddress);
      await _storage.write(key: 'babylon_address', value: _babylonAddress);

      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la création du wallet: $e');
      rethrow;
    }
  }

  Future<String> bridgeToBabylon({
    required double amount,
    String? destinationAddress,
  }) async {
    try {
      final txHash = 'hash_simulé_${DateTime.now().millisecondsSinceEpoch}';
      
      _transactions.add(BridgeTransaction(
        hash: txHash,
        amount: amount,
        sourceAddress: btcAddress,
        destinationAddress: destinationAddress ?? babylonAddress,
        direction: BridgeDirection.toBabylon,
        status: TransactionStatus.pending,
        timestamp: DateTime.now(),
      ));

      _btcBalance -= amount;
      _wrappedBalance += amount;
      notifyListeners();

      return txHash;
    } catch (e) {
      debugPrint('Erreur lors du bridge vers Babylon: $e');
      rethrow;
    }
  }

  Future<String> bridgeFromBabylon({
    required double amount,
    String? destinationAddress,
  }) async {
    try {
      final txHash = 'hash_simulé_${DateTime.now().millisecondsSinceEpoch}';
      
      _transactions.add(BridgeTransaction(
        hash: txHash,
        amount: amount,
        sourceAddress: babylonAddress,
        destinationAddress: destinationAddress ?? btcAddress,
        direction: BridgeDirection.toBitcoin,
        status: TransactionStatus.pending,
        timestamp: DateTime.now(),
      ));

      _wrappedBalance -= amount;
      _btcBalance += amount;
      notifyListeners();

      return txHash;
    } catch (e) {
      debugPrint('Erreur lors du bridge vers Bitcoin: $e');
      rethrow;
    }
  }

  Future<void> refreshBalances() async {
    try {
      // Simulé pour l'exemple
      _btcBalance = 1.0;
      _wrappedBalance = 0.5;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des balances: $e');
      rethrow;
    }
  }

  Future<List<BridgeTransaction>> getTransactionHistory() async {
    try {
      return _transactions;
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'historique: $e');
      return [];
    }
  }
}