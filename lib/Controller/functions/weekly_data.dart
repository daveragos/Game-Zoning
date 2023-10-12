import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/functions/incomes.dart';

//provider
final weeklyDataProvider =
    StateNotifierProvider<WeeklyData, Map<String, dynamic>>(
        (ref) => WeeklyData());

class WeeklyData extends StateNotifier<Map<String, dynamic>> {
  WeeklyData() : super({});

  Future<void> getData({required selectedDate}) async {
    final response =
        await Income().getAllWeeklyData(selectedDate: selectedDate);
    final gameDataList = response;
    final gameGroupData = <String, List<Map<String, dynamic>>>{};

    for (var gameData in gameDataList) {
      String gameName = gameData['game_name'];
      double amount = gameData['amount'];
      String date = gameData['date'];

      if (!gameGroupData.containsKey(gameName)) {
        gameGroupData[gameName] = [];
      }

      gameGroupData[gameName]?.add({'amount': amount, 'date': date});
      gameGroupData[gameName]?.sort((a, b) => a['date'].compareTo(
          b['date'])); // Sort the game data items by date in ascending order
    }

    double totalAmount = 0;

    for (var gameData in gameDataList) {
      double amount = gameData['amount'];
      totalAmount += amount;
    }

    final gamePercentages = <String, double>{};

    for (var gameName in gameGroupData.keys) {
      double gameTotal = 0;

      for (var gameData in gameGroupData[gameName]!) {
        double amount = gameData['amount'];
        gameTotal += amount;
      }

      double percentage = gameTotal / totalAmount * 100;
      gamePercentages[gameName] = percentage;
    }

    state = {
      'gameDataList': gameDataList,
      'gameGroupData': gameGroupData,
      'totalAmount': totalAmount,
      'gamePercentages': gamePercentages,
    };
  }
}
