import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';
import 'package:gamezoning/View/widgets/drawer_widget.dart';
import 'package:gamezoning/View/widgets/homepage_widget.dart';
import 'package:go_router/go_router.dart';

class EmployeeHome extends ConsumerStatefulWidget {
  const EmployeeHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends ConsumerState<EmployeeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          AppRouter.addingPagePath,
        ),
        child: const Icon(Icons.add),
      ),
      body: const HomePage(),
    );
  }
}
