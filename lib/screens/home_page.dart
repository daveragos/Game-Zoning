// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Game Zoning',
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              context.go('/OwnerHome');
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                  ),
                  SizedBox(height: 10),
                  Text('Gamer'),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('addingpage');
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoContainer('Total Income : 47132.32'),
                  SizedBox(width: 10),
                  _buildInfoContainer('Mon-Aug-28'),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 260,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 20,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                var style = TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold);
                                switch (value.toInt()) {
                                  case 0:
                                    return Text(
                                      'Betting',
                                      style: style,
                                    );
                                  case 1:
                                    return Text(
                                      'Coffee',
                                      style: style,
                                    );
                                  case 2:
                                    return Text(
                                      'DSTV',
                                      style: style,
                                    );
                                  case 3:
                                    return Text(
                                      'Pool',
                                      style: style,
                                    );
                                  case 4:
                                    return Text(
                                      'PS',
                                      style: style,
                                    );
                                  case 5:
                                    return Text(
                                      'VR',
                                      style: style,
                                    );
                                  default:
                                    return Text('');
                                }
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false))),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: [
                        _buildBarGroupData(0, 8, Colors.lightGreen),
                        _buildBarGroupData(1, 10, Colors.lightGreen),
                        _buildBarGroupData(2, 14, Colors.lightGreen),
                        _buildBarGroupData(3, 15, Colors.lightGreen),
                        _buildBarGroupData(4, 12, Colors.lightGreen),
                        _buildBarGroupData(5, 10, Colors.lightGreen),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _pickDate;
                        },
                        child: Text('Pick Date')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic get _pickDate => {
        showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
      };

  Container _buildInfoContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  BarChartGroupData _buildBarGroupData(double x, double y, Color color) {
    return BarChartGroupData(
      x: x.toInt(),
      barRods: [
        BarChartRodData(
            toY: y,
            color: color,
            width: 30,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[400],
            ),
            borderRadius: BorderRadius.circular(8)),
      ],
    );
  }
}
