import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';
import 'package:intl/intl.dart';

class SideDetail extends ConsumerWidget {
  const SideDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabbed = ref.watch(selectedTabProvider);
    final detailData =
        ref.watch(weeklyDataProvider.notifier).state['gameGroupData'];
    if (detailData == null || detailData.isEmpty) {
      // Handle the case where detailData is empty
      return const Center(
        child: Text(
          '',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else if (tabbed >= detailData.length) {
      // Handle the case where tabbed is an invalid index for the list
      return const Center(
        child: Text(
          'Invalid tab index',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      final gameData = detailData.values.toList()[tabbed];
      // Use the gameData variable as needed

      // final gameData = detailData.values.toList()[tabbed];
      final gameName = detailData.keys.toList()[tabbed];
      final data = gameData ?? [];

      double total = 0.0;
      // Ensure that 'tabbed' is within the valid range
      if (tabbed >= 0 && tabbed < detailData.length) {
        final selectedKey = detailData.keys.elementAt(tabbed);
        final data = detailData[selectedKey] ?? [];

        for (var item in data) {
          if (item['amount'] is double) {
            total += item['amount'];
          } else if (item['amount'] is int) {
            total += (item['amount'] as int).toDouble();
          }
        }

        print("Total amount for $selectedKey: $total");
      } else {
        print("Invalid 'tabbed' index.");
      }
      return Column(
        children: [
          Text(
            gameName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * .07,
              decoration: TextDecoration.underline,
            ),
          ),
          for (final item in data)
            Text(
              '${DateFormat.E().format(DateTime.parse(item['date']))}: ${item['amount'].toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          Text(
            'Total: ${total.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * .07,
            ),
          ),
        ],
      );
    }
  }
}
