//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:gamezoning/Controller/Auth/authcheck.dart';
import 'package:gamezoning/View/Home/login_screen.dart';
import 'package:gamezoning/View/Home/register_page.dart';
import 'package:gamezoning/View/employee/adding_page.dart';
import 'package:gamezoning/View/widgets/home_page.dart';
import 'package:gamezoning/View/owner/swapping_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // GoRouter configuration
  var router = GoRouter(
    initialLocation: '/',
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
                    child: Scaffold(
                  body: Center(
                    child: Text('Line Chart Page'),
                  ),
                ));
              },
            ),
            GoRoute(
                name: 'OwnerHomePage',
                path: '/OwnerHome',
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: HomePage());
                },
                routes: [
                  GoRoute(
                    name: 'addingpage',
                    path: 'addingpage',
                    builder: (context, state) => AddingPage(),
                  ),
                ]),
            GoRoute(
              name: 'PieChartPage',
              path: '/PieChartPage',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: Scaffold(
                  body: Center(
                    child: Text('Pie Chart Page'),
                  ),
                ));
              },
            ),
          ])
    ],
  );
}
