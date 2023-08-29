// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddingPage extends ConsumerStatefulWidget {
  const AddingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddingPageState();
}

class _AddingPageState extends ConsumerState<AddingPage> {
  @override
  Widget build(BuildContext context) {
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
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
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
                        'Pick Date',
                        style: TextStyle(fontSize: 33),
                      ),
                      icon: Icon(Icons.calendar_month),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime.now(),
                        );
                      },
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
                    onPressed: () {},
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
}
