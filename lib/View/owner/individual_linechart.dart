import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';
import 'package:gamezoning/View/widgets/drawer_widget.dart';

class IndividualLineTab extends ConsumerStatefulWidget {
  const IndividualLineTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLineTabState();
}

class _IndividualLineTabState extends ConsumerState<IndividualLineTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: Center(
        child: Text('individual widget'),
      ),
    );
  }
}
