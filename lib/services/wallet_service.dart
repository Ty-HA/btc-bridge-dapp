import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';

class WalletService extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  late final Web3Client _client;
  _client = Web3Client(EnvConfig.infuraUrl, http.Client());

  
  String? _privateKey;
  String? _address;
  
  bool get isInitialized => _privateKey != null;
  String get address => _address ?? '';

  Future<void> initializeWallet() async {
    // Initialisation du wallet à implémenter
  }

  Future<void> createWallet() async {
    // Création du wallet à implémenter
  }

  Future<void> importWallet(String privateKey) async {
    // Import du wallet à implémenter
  }

  Future<double> getBalance() async {
    // Récupération de la balance à implémenter
    return 0.0;
  }

  Future<String> sendTransaction({
    required String to,
    required double amount,
  }) async {
    // Envoi de transaction à implémenter
    return '';
  }
}