// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:gamezoning/View/Home/login_screen.dart';
import 'package:gamezoning/View/employee/e_home_page.dart';
import 'package:gamezoning/View/owner/o_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends ConsumerStatefulWidget {
  const AuthCheck({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthCheckState();
}

class _AuthCheckState extends ConsumerState<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            final token = snapshot.data!
                .getString(AppConstants.STORAGE_USER_PROFILE_TOKEN);
            if (token != null) {
              return EmployeeHome();
            } else {
              return LoginScreen();
            }
          } else if (snapshot.hasError) {
            return Text('Some Error Occured');
          } else {
            return LoginScreen();
          }
        });
  }
}
