import 'package:flutter/material.dart';

class TVCounterPage extends StatefulWidget {
  const TVCounterPage({super.key});

  @override
  State<TVCounterPage> createState() => _TVCounterPageState();
}

class _TVCounterPageState extends State<TVCounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return const Card(
            color: Colors.tealAccent,
            margin: EdgeInsets.all(5),
            child: Center(
              child: Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
