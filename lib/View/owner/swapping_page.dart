import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';
import 'package:gamezoning/View/widgets/bottom_nav_widget.dart';
import 'package:gamezoning/View/widgets/drawer_widget.dart';

class SwappingPage extends ConsumerStatefulWidget {
  const SwappingPage({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwappingPageState();
}

class _SwappingPageState extends ConsumerState<SwappingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: widget.child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
