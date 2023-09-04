import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/View/owner/linechart_widget.dart';
import 'package:gamezoning/View/owner/weekly_page.dart';
import 'package:gamezoning/View/owner/weekly_pie_page.dart';
import 'package:gamezoning/View/widgets/appbar_widget.dart';

class IndividualLineTabPage extends ConsumerStatefulWidget {
  const IndividualLineTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLineTabPageState();
}

class _IndividualLineTabPageState extends ConsumerState<IndividualLineTabPage>
    with TickerProviderStateMixin {
// Generate some dummy data for the cahrt
  // This will be used to draw the red line
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    final tabController = TabController(length: 6, vsync: this);
    return DefaultTabController(
      length: 6,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            isScrollable: true,
            onTap: (value) {
              print('££££££££££££££££££££ $value');
              ref.read(selectedTabProvider.notifier).setSelectedTab(value);
            },
            tabs: const [
              Tab(
                text: 'Betting',
                icon: Icon(FontAwesomeIcons.dice),
              ),
              Tab(
                text: 'Coffee',
                icon: Icon(FontAwesomeIcons.mugHot),
              ),
              Tab(
                text: 'DsTv',
                icon: Icon(FontAwesomeIcons.tv),
              ),
              Tab(
                text: 'Pool',
                icon: Icon(FontAwesomeIcons.eight),
              ),
              Tab(
                text: 'PS',
                icon: Icon(FontAwesomeIcons.gamepad),
              ),
              Tab(
                text: 'VR',
                icon: Icon(FontAwesomeIcons.vrCardboard),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: SizedBox(
                    height: 300,
                    width: 400,
                    child: LineChartWidget(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: SizedBox(
                    height: 300,
                    width: 400,
                    child: LineChartWidget(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: SizedBox(
                    height: 300,
                    width: 400,
                    child: LineChartWidget(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: SizedBox(
                    height: 300,
                    width: 400,
                    child: LineChartWidget(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: SizedBox(
                    height: 300,
                    width: 400,
                    child: LineChartWidget(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: SizedBox(
                    height: 300,
                    width: 400,
                    child: LineChartWidget(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200, width: 200, child: PieChartSample2()),
              Column(
                children: [
                  Text(
                    'Game Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .07,
                        decoration: TextDecoration.underline),
                  ),
                  const Text('Mon: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Tue: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Wed: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Thu: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Fri: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Sat: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Sun: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    'Total: 7213',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .07),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/*
Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: SizedBox(
                height: 300,
                width: 400,
                child: LineChartWidget(
                    dummyData1: dummyData1,
                    dummyData2: dummyData2,
                    dummyData3: dummyData3),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 200, height: 200, child: WeeklyPiePage()),
                Column(
                  children: [
                    Text(
                      'Game Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    Text('Mon: 7213'),
                    Text('Tue: 7213'),
                    Text('Wed: 7213'),
                    Text('Thu: 7213'),
                    Text('Fri: 7213'),
                    Text('Sat: 7213'),
                    Text(
                      'Sun: 7213',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Text(
                      'Total: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),*/