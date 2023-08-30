import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';
import 'package:gamezoning/View/widgets/drawer_widget.dart';
import 'package:gamezoning/View/widgets/home_page.dart';

class OHomePage extends ConsumerStatefulWidget {
  const OHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OHomePageState();
}

class _OHomePageState extends ConsumerState<OHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: HomePage(),
    );
  }
}
