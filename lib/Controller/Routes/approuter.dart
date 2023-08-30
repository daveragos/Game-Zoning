//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:gamezoning/Controller/Auth/authcheck.dart';
import 'package:gamezoning/View/Home/login_screen.dart';
import 'package:gamezoning/View/Home/register_page.dart';
import 'package:gamezoning/View/employee/adding_page.dart';
import 'package:gamezoning/View/owner/individualLineTab_page.dart';
import 'package:gamezoning/View/owner/o_home_page.dart';
import 'package:gamezoning/View/owner/weekly_pie_page.dart';
import 'package:gamezoning/View/widgets/homepage_widget.dart';
import 'package:gamezoning/View/owner/swapping_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // GoRouter configuration
  var router = GoRouter(
    initialLocation: '/LineChartPage',
    routes: [
      GoRoute(
        name: 'authcheck',
        path: '/',
        builder: (context, state) => AuthCheck(),
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        name: 'EmployeeHome',
        path: '/EmployeeHome',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            name: 'addingpage',
            path: 'addingpage',
            builder: (context, state) => AddingPage(),
          ),
        ],
      ),
      //the bottom navigation bar
      ShellRoute(
        builder: (context, state, child) => SwappingPage(
          key: state.pageKey,
          child: child,
        ),
        routes: [
          GoRoute(
            name: 'LineChartPage',
            path: '/LineChartPage',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: IndividualLineTabPage(),
              );
            },
          ),
          GoRoute(
            name: 'OwnerHomePage',
            path: '/OwnerHome',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: OwnerHome(),
              );
            },
          ),
          GoRoute(
            name: 'PieChartPage',
            path: '/PieChartPage',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: WeeklyPiePage(),
              );
            },
          ),
        ],
      )
    ],
  );
}
