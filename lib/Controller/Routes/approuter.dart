//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:gamezoning/Controller/Auth/authcheck.dart';
import 'package:gamezoning/View/Home/login_screen.dart';
import 'package:gamezoning/View/Home/register_page.dart';
import 'package:gamezoning/View/employee/adding_page.dart';
import 'package:gamezoning/View/employee/e_home_page.dart';
import 'package:gamezoning/View/owner/individual_linetab_page.dart';
import 'package:gamezoning/View/owner/o_home_page.dart';
import 'package:gamezoning/View/owner/swapping_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String ownerHomePath = '/OwnerHome';
  static const String loginPath = '/login';
  static const String registerPath = '/register';
  static const String addingPagePath = '/addingpage';
  static const String lineChartPagePath = '/LineChartPage';
  static const String employeeHomePath = '/EmployeeHome';

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
        path: registerPath,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        name: 'login',
        path: loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'addingpage',
        path: addingPagePath,
        builder: (context, state) => AddingPage(),
      ),

      GoRoute(
        name: 'EmployeeHome',
        path: employeeHomePath,
        builder: (context, state) => const EmployeeHome(),
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
            path: lineChartPagePath,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: IndividualLineTabPage(),
              );
            },
          ),
          GoRoute(
            name: 'OwnerHomePage',
            path: ownerHomePath,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: OwnerHome(),
              );
            },
          ),
        ],
      )
    ],
  );
}
