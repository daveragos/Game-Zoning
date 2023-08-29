//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:gamezoning/Auth/authcheck.dart';
import 'package:gamezoning/screens/adding_page.dart';
import 'package:gamezoning/screens/home_page.dart';
import 'package:gamezoning/screens/login_screen.dart';
import 'package:gamezoning/screens/owner/o_home_page.dart';
import 'package:gamezoning/screens/owner/swapping_page.dart';
import 'package:gamezoning/screens/register_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // final GlobalKey<NavigatorState> _rootNavigator =
  //     GlobalKey(debugLabel: 'root');
  // final GlobalKey<NavigatorState> _shellNavigator =
  //     GlobalKey(debugLabel: 'shell');
  // GoRouter configuration
  var router = GoRouter(
    initialLocation: '/register',
    routes: [
      GoRoute(
        name:
            'authcheck', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: '/',
        builder: (context, state) => AuthCheck(),
      ),
      // GoRoute(
      //   name: 'home',
      //   path: '/home',
      //   builder: (context, state) => HomePage(),
      // ),

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
