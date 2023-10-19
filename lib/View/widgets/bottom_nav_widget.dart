import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Provider/position_provider.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(positionProvider);
    return CurvedNavigationBar(
      index: position,
      color: Colors.green,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (value) => onTap(value),
      items: const [
        Icon(FontAwesomeIcons.chartLine),
        Icon(FontAwesomeIcons.house),
      ],
    );
  }

  void onTap(int value) {
    ref.read(positionProvider.notifier).setPosition(value);
    switch (value) {
      case 0:
        context.go(AppRouter.lineChartPagePath);
        break;
      case 1:
        context.go(AppRouter.ownerHomePath);
        break;
    }
  }
}
