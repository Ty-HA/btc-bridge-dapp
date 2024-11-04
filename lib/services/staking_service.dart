import 'package:flutter/foundation.dart';

class StakingService extends ChangeNotifier {
  // Données simulées pour le staking
  final _stakedAmount = 1.25;
  double _totalRewards = 0.0876;
  double _apy = 4.5;
  List<ValidatorInfo> _validators = [];
  List<DailyReward> _rewardHistory = [];
  PerformanceData _performance = PerformanceData();
  
  // Getters
  double get stakedAmount => _stakedAmount;
  double get totalRewards => _totalRewards;
  double get apy => _apy;
  List<ValidatorInfo> get validators => _validators;
  List<DailyReward> get rewardHistory => _rewardHistory;
  PerformanceData get performance => _performance;

  StakingService() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Simuler le chargement des données
    await Future.delayed(const Duration(seconds: 1));
    
    // Générer des validateurs simulés
    _validators = List.generate(5, (index) => ValidatorInfo(
      name: 'Validator ${index + 1}',
      address: '0x${index}abc...',
      stakedAmount: (1.0 + index * 0.5),
      uptime: 98.5 + (index * 0.3),
      commission: 5.0 + (index * 1.0),
    ));

    // Générer l'historique des récompenses
    final now = DateTime.now();
    _rewardHistory = List.generate(30, (index) {
      return DailyReward(
        date: now.subtract(Duration(days: 29 - index)),
        amount: 0.001 + (index * 0.0001),
      );
    });

    // Initialiser les métriques de performance
    _performance = PerformanceData(
      dailyReward: 0.003,
      weeklyReward: 0.021,
      monthlyReward: 0.0876,
      totalValue: _stakedAmount * 35000, // Prix BTC simulé
      projectedAnnualReward: 1.05,
    );

    notifyListeners();
  }

  Future<void> refreshData() async {
    // Simuler un rafraîchissement des données
    await Future.delayed(const Duration(seconds: 1));
    _totalRewards += 0.0001;
    _apy += 0.1;
    
    // Mettre à jour l'historique des récompenses
    final lastReward = _rewardHistory.last;
    _rewardHistory.add(DailyReward(
      date: lastReward.date.add(const Duration(days: 1)),
      amount: lastReward.amount + 0.0001,
    ));
    _rewardHistory.removeAt(0);

    notifyListeners();
  }
}

class ValidatorInfo {
  final String name;
  final String address;
  final double stakedAmount;
  final double uptime;
  final double commission;

  ValidatorInfo({
    required this.name,
    required this.address,
    required this.stakedAmount,
    required this.uptime,
    required this.commission,
  });
}

class DailyReward {
  final DateTime date;
  final double amount;

  DailyReward({
    required this.date,
    required this.amount,
  });
}

class PerformanceData {
  final double dailyReward;
  final double weeklyReward;
  final double monthlyReward;
  final double totalValue;
  final double projectedAnnualReward;

  PerformanceData({
    this.dailyReward = 0.0,
    this.weeklyReward = 0.0,
    this.monthlyReward = 0.0,
    this.totalValue = 0.0,
    this.projectedAnnualReward = 0.0,
  });
}