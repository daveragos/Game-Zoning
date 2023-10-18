import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/functions/incomes.dart';

//provider
final weeklyDataProvider =
    StateNotifierProvider<WeeklyData, Map<String, dynamic>>(
        (ref) => WeeklyData());

class WeeklyData extends StateNotifier<Map<String, dynamic>> {
  WeeklyData() : super({});

  Future<void> getData({required selectedDate, required context}) async {
    final response = await Income()
        .getAllWeeklyData(selectedDate: selectedDate, context: context);
    final gameDataList = response;
    final gameGroupData = <String, List<Map<String, dynamic>>>{};

    // Predefine your game names
    final gameNames = ['betting', 'coffee', 'dstv', 'pool', 'ps', 'vr'];

    // Initialize gameGroupData for each game name
    for (var gameName in gameNames) {
      gameGroupData[gameName] = [];
    }

    // Populate gameGroupData with data from gameDataList
    for (var gameData in gameDataList!) {
      String gameName = gameData['game_name'].toLowerCase();
      double amount = gameData['amount'];
      String date = gameData['date'];

      gameGroupData[gameName]!.add({'amount': amount, 'date': date});
    }

    // For each game name, check and add missing dates with 0.0 amount
    for (var gameName in gameNames) {
      for (var gameData in gameGroupData[gameName]!) {
        // Get a list of unique dates for the current game name
        final uniqueDates = gameGroupData[gameName]!
            .map((entry) => entry['date'])
            .toSet()
            .toList();

        // Iterate over unique dates and add missing dates with 0.0 amount
        for (var date in uniqueDates) {
          bool dateExists =
              gameGroupData[gameName]!.any((entry) => entry['date'] == date);
          if (!dateExists) {
            gameGroupData[gameName]!.add({'amount': 0.0, 'date': date});
          }
        }
      }
    }

    // Sort the game data items by date in ascending order
    for (var gameName in gameNames) {
      gameGroupData[gameName]?.sort((a, b) => a['date'].compareTo(b['date']));
    }

    double totalAmount = 0;

    for (var gameData in gameDataList) {
      double amount = gameData['amount'];
      totalAmount += amount;
    }

    final gamePercentages = <String, double>{};

    for (var gameName in gameNames) {
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
