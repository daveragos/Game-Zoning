//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:gamezoning/Auth/authcheck.dart';
import 'package:gamezoning/screens/adding_page.dart';
import 'package:gamezoning/screens/home_page.dart';
import 'package:gamezoning/screens/login_screen.dart';
import 'package:gamezoning/screens/register_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
// GoRouter configuration
  var router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        name:
            'authcheck', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: '/',
        builder: (context, state) => AuthCheck(),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        name: 'adding',
        path: '/adding',
        builder: (context, state) => AddingPage(),
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
    ],
  );
}
