import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';
import 'package:gamezoning/View/owner/owner_drawer_widget.dart';
import 'package:gamezoning/View/widgets/homepage_widget.dart';

class OwnerHome extends ConsumerStatefulWidget {
  const OwnerHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends ConsumerState<OwnerHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      drawer: OwnerDrawerWidget(),
      body: HomePage(),
    );
  }
}
