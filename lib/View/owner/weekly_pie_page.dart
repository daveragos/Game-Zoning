import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyPiePage extends ConsumerStatefulWidget {
  const WeeklyPiePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeeklyPiePageState();
}

class _WeeklyPiePageState extends ConsumerState<WeeklyPiePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Weekly PIE widget'),
      ),
    );
  }
}
