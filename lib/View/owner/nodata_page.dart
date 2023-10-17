import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Data'),
      ),
      body: Center(
        child: Text(
          'There is no data for the selected date.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
