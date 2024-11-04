// lib/config/env_config.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get bitcoinNetwork => dotenv.env['BITCOIN_NETWORK'] ?? 'testnet';
  static String get bitcoinNodeUrl => dotenv.env['BITCOIN_NODE_URL'] ?? 'https://testnet.bitcoin.com/api';
  static String get rskNodeUrl => dotenv.env['RSK_NODE_URL'] ?? 'https://public-node.testnet.rsk.co';
  
  static bool get isDevelopment => 
      dotenv.env['ENVIRONMENT']?.toLowerCase() == 'development';
}