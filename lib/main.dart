import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/staking_service.dart';
import 'services/babylon_bridge_service.dart';
import 'screens/main_screen.dart';
import 'screens/relayer_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StakingService()),
        ChangeNotifierProvider(create: (_) => BabylonBridgeService()),
      ],
      child: MaterialApp(
        title: 'BTC Staking Monitor',
        theme: AppTheme.getDarkTheme(),
        initialRoute: '/',  // Définir la route initiale
        routes: {
          '/': (context) => const MainScreen(),  // Route principale
          '/relayers': (context) => const RelayerScreen(),  // Route des relayers
        },
      ),
    );
  }
}