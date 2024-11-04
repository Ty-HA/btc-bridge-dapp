import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/env_config.dart';
import 'screens/home_screen.dart';
import 'services/wallet_service.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  if (EnvConfig.isDevelopment) {
    EnvConfig.validate();
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => WalletService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTC Bridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}