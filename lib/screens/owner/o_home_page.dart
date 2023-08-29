import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/screens/owner/bottom_nav.dart';

class OHomePage extends ConsumerStatefulWidget {
  const OHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OHomePageState();
}

class _OHomePageState extends ConsumerState<OHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Owner Home Page'),
      ),
    );
  }
}
