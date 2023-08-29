import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/screens/owner/bottom_nav.dart';

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
      body: widget.child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
