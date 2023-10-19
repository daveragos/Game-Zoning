import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Provider/employee_provider.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:gamezoning/Controller/functions/employee_getter.dart';
import 'package:gamezoning/Controller/functions/incomes.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';
import 'package:gamezoning/View/owner/owner_drawer_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerLandingPage extends ConsumerStatefulWidget {
  const OwnerLandingPage({super.key});

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
        appBar: const AppBarWidget(),
        drawer: const OwnerDrawerWidget(),
        body: !isLoading
            ? employees.isEmpty
                ? const Center(
                    child: Text('You have no employees.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                : Center(
                    child: Column(
                      children: [
                        const Text('Choose an employee',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: employees.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(FontAwesomeIcons.user),
                                    title: Text(employees[index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    onTap: () {
                                      ref
                                          .read(
                                              selectedEmployeeProvider.notifier)
                                          .setSelectedEmployee(index);
                                      ref
                                          .watch(employeeProvider.notifier)
                                          .setName(employees[index]);
                                      final selectedUsername =
                                          ref.watch(employeeProvider);
                                      pref.setString(
                                          AppConstants
                                              .STORAGE_USER_PROFILE_employee_username,
                                          selectedUsername);
                                      GoRouter.of(context)
                                          .go(AppRouter.ownerHomePath);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
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
