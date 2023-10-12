import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Provider/date_provider.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/Controller/functions/employee_getter.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';
import 'package:gamezoning/View/owner/linechart_widget.dart';
import 'package:gamezoning/View/owner/side_detail_page.dart';
import 'package:gamezoning/View/owner/weekly_pie_page.dart';
import 'package:intl/intl.dart';

class IndividualLineTab extends ConsumerStatefulWidget {
  const IndividualLineTab({super.key});

  @override
  ConsumerState<IndividualLineTab> createState() => _IndividualLineTabState();
}

class _IndividualLineTabState extends ConsumerState<IndividualLineTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var weeklyData;
  bool isLoading = false;
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    selectedDate = ref.read(selectedDateProvider);
    getData();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    ref
        .watch(selectedTabProvider.notifier)
        .setSelectedTab(_tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = ref.watch(selectedDateProvider);
    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    controller: _tabController,
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
                      controller: _tabController,
                      children: List.generate(
                        _tabController.length,
                        (index) => const LineWidget(),
                      ),
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
    await ref
        .read(weeklyDataProvider.notifier)
        .getData(selectedDate: selectedDate);
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
