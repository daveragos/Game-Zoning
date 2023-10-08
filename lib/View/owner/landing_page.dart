import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/employee_provider.dart';
import 'package:gamezoning/Controller/functions/incomes.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';
import 'package:gamezoning/View/owner/o_home_page.dart';
import 'package:gamezoning/View/owner/swapping_page.dart';
import 'package:go_router/go_router.dart';

class OwnerLandingPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<OwnerLandingPage> createState() => _OwnerLandingPageState();
}

class _OwnerLandingPageState extends ConsumerState<OwnerLandingPage> {
  bool isLoading = false;
  List<String> employees = [];

  @override
  void initState() {
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    employees = await Income().getAllEmployee() as List<String>;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? employees.isEmpty
              ? const Center(
                  child: Text('You have no employees.'),
                )
              : employees.length == 1
                  ? const SwappingPage(child: OwnerHome())
                  : Center(
                      child: Column(
                        children: [
                          const Text('Choose an employee'),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: employees.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(employees[index]),
                                onTap: () {
                                  ref
                                      .read(selectedEmployeeProvider.notifier)
                                      .setSelectedEmployee(index);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
