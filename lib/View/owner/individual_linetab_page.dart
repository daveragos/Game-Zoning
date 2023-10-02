import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';
import 'package:gamezoning/View/owner/linechart_widget.dart';
import 'package:gamezoning/View/owner/weekly_page.dart';

class IndividualLineTabPage extends ConsumerStatefulWidget {
  const IndividualLineTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLineTabPageState();
}

class _IndividualLineTabPageState extends ConsumerState<IndividualLineTabPage>
    with TickerProviderStateMixin {
  final weeklyData = WeeklyData();
  @override
  void initState() async {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final tabController = TabController(length: 6, vsync: this);
    return SafeArea(
      child: DefaultTabController(
        length: 6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: tabController,
              isScrollable: true,
              onTap: (value) {
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
            Flexible(
              child: TabBarView(
                controller: tabController,
                children: const [
                  LineWidget(),
                  LineWidget(),
                  LineWidget(),
                  LineWidget(),
                  LineWidget(),
                  LineWidget(),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200, width: 200, child: PieChartSample2()),
                SideDetail(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getData() async {
    await weeklyData.getData;
    final state = weeklyData.state;
    print(
        'EXTRACTED DATA IS : IIIIIIIIIIIIIIIIIIIII ||||||||| ${state['gameGroupData']}');
    print('TOTAL AMOUNT IS : ${state['totalAmount']}');
    print('GAME PERCENTAGES ARE : ${state['gamePercentages']}');
    print(
        'WWWWWWWWEEEEEEEEEEEKKKKKKKKLLLLLLLLLLLYYYYYYYYYY DATA :::::::: $weeklyData');
  }
}

class SideDetail extends StatelessWidget {
  const SideDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Game Name',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * .07,
              decoration: TextDecoration.underline),
        ),
        const Text('Mon: 7213', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Tue: 7213', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Wed: 7213', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Thu: 7213', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Fri: 7213', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Sat: 7213', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Sun: 7213', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Total: 7213',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * .07),
        ),
      ],
    );
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: SizedBox(
        height: 300,
        width: 400,
        child: LineChartWidget(),
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