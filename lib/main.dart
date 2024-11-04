import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/babylon_bridge_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BabylonBridgeService(),
      child: MaterialApp(
        title: 'BTC Bridge',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF1A1A1A),
          cardTheme: CardTheme(
            color: Colors.grey[900],
            elevation: 8,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}