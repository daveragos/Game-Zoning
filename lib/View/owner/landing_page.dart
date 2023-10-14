import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/employee_provider.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:gamezoning/Controller/functions/employee_getter.dart';
import 'package:gamezoning/Controller/functions/incomes.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:gamezoning/View/owner/o_home_page.dart';
import 'package:gamezoning/View/owner/swapping_page.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';
import 'package:gamezoning/View/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerLandingPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<OwnerLandingPage> createState() => _OwnerLandingPageState();
}

class _OwnerLandingPageState extends ConsumerState<OwnerLandingPage> {
  bool isLoading = false;
  List<String> employees = [];
  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      employees = await Income().getEmployeesUsernames(context: context);
      pref = await SharedPreferences.getInstance();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        drawer: DrawerWidget(),
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
                                    ref
                                        .watch(employeeProvider.notifier)
                                        .setName(employees[index]);
                                    final selectedUsername = ref
                                        .watch(employeeProvider.notifier)
                                        .state;
                                    pref.setString(
                                        AppConstants
                                            .STORAGE_USER_PROFILE_employee_username,
                                        selectedUsername);
                                    GoRouter.of(context)
                                        .go(AppRouter.ownerHomePath);
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
      ),
    );
  }
}
