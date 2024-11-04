import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get infuraKey => dotenv.env['INFURA_KEY'] ?? '';
  static String get etherscanApiKey => dotenv.env['ETHERSCAN_API_KEY'] ?? '';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  
  static String get infuraUrl => 'https://mainnet.infura.io/v3/$infuraKey';
  
  static bool get isDevelopment => environment == 'development';
  
  // Fonction de validation des variables d'environnement
  static void validate() {
    assert(infuraKey.isNotEmpty, 'INFURA_KEY is not set in .env file');
    assert(etherscanApiKey.isNotEmpty, 'ETHERSCAN_API_KEY is not set in .env file');
  }
}