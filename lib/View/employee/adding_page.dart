// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/date_provider.dart';
import 'package:gamezoning/Controller/functions/employee_getter.dart';
import 'package:gamezoning/Controller/functions/incomes.dart';
import 'package:intl/intl.dart';

class AddingPage extends ConsumerStatefulWidget {
  const AddingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddingPageState();
}

class _AddingPageState extends ConsumerState<AddingPage> {
  DateTime? selectedDate;
  TextEditingController amountController = TextEditingController(text: '');
  TextEditingController gameController = TextEditingController(text: '');

  @override
  void initState() {
    selectedDate = ref.read(selectedDateProvider);
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateWatcher = ref.watch(selectedDateProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Add Income Here',
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownMenu(
                      width: 300,
                      leadingIcon: Icon(Icons.gamepad),
                      trailingIcon: Icon(Icons.arrow_drop_down_circle_outlined),
                      hintText: 'Select Game Type',
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 'betting', label: 'Betting'),
                        DropdownMenuEntry(value: 'coffee', label: 'Coffee'),
                        DropdownMenuEntry(value: 'dstv', label: 'DSTV'),
                        DropdownMenuEntry(value: 'pool', label: 'Pool'),
                        DropdownMenuEntry(value: 'ps', label: 'PS'),
                        DropdownMenuEntry(value: 'vr', label: 'VR'),
                      ],
                      controller: gameController,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter amount',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton.icon(
                      label: Text(
                        'Currently Picked Date : ${DateFormat('yyyy-MM-dd').format(selectedDateWatcher)}',
                        style: TextStyle(fontSize: 23),
                      ),
                      icon: Icon(Icons.calendar_month),
                      onPressed: () => _openDatePicker(),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () => submit(selectedDate: selectedDateWatcher),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 25),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openDatePicker() async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      ref.watch(selectedDateProvider.notifier).setDate(selectedDate!);
    } else {
      ref.watch(selectedDateProvider.notifier).resetDate();
    }
  }

  submit({required selectedDate}) {
    if (gameController.text.isNotEmpty && amountController.text.isNotEmpty) {
      // Add the data to the database
      //format the selectedDate to yyyy-mm-dd
      String formattedSelectedDate =
          DateFormat('yyyy-MM-dd').format(selectedDate);
      final selectedEmployee = ref.read(employeeProvider.notifier).state;

      Income().addIncomeData(
        employeeUserName: selectedEmployee,
        gameName: gameController.text,
        amount: amountController.text,
        date: formattedSelectedDate,
      );

      print(gameController.text);
      print(amountController.text);
      print(selectedDate.toString());

      // Clear the text fields
      gameController.clear();
      amountController.clear();
      selectedDate = null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all the fields'),
        ),
      );
    }
  }
}
