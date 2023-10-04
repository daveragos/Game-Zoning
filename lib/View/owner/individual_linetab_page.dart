import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';
import 'package:gamezoning/View/owner/linechart_widget.dart';
import 'package:gamezoning/View/owner/side_detail_page.dart';
import 'package:gamezoning/View/owner/weekly_pie_page.dart';
import 'package:intl/intl.dart';

class IndividualLineTabPage extends ConsumerStatefulWidget {
  const IndividualLineTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLineTabPageState();
}

class _IndividualLineTabPageState extends ConsumerState<IndividualLineTabPage>
    with TickerProviderStateMixin {
  var weeklyData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final tabController = TabController(length: 6, vsync: this);
    return SafeArea(
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    controller: tabController,
                    isScrollable: true,
                    onTap: (value) {
                      ref
                          .watch(selectedTabProvider.notifier)
                          .setSelectedTab(value);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 200, width: 200, child: PieChartSample2()),
                      SideDetail(),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    await ref.read(weeklyDataProvider.notifier).getData();
    weeklyData = ref.read(weeklyDataProvider.notifier).state;
    print(weeklyData['gameGroupData']);
    setState(() {
      isLoading = false;
    });
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: SizedBox(
        height: 400,
        width: 400,
        child: LineChartWidget(),
      ),
    );
  }
}
