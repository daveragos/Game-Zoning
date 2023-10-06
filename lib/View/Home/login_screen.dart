// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Constants/https_route_consts.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:gamezoning/Model/api.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:gamezoning/View/widgets/toggler.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isOwner =
      true; // Add a boolean variable to track if the user is an owner or employee

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void login() async {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill all the fields'),
          ),
        );
      } else if (!emailController.text.contains('@') ||
          !emailController.text.contains('.')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid email'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logging You In...'),
          ),
        );
        //! uploading to the server
        final route =
            isOwner // Determine the route based on the value of isOwner
                ? Constants.OWNERS_LOGIN_URL
                : Constants.EMPLOYEES_LOGIN_URL;
        final result = await API().postRequest(route: route, data: {
          'email': emailController.text.toString(),
          'password': passwordController.text.toString(),
        });
        // print(jsonDecode(result.toString()));
        if (result.statusCode == 200) {
          //! storing the login info of the user to local db
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString(AppConstants.STORAGE_USER_PROFILE_KEY,
              result.data['user'].toString());
          await pref.setString(AppConstants.STORAGE_USER_PROFILE_TOKEN,
              result.data['token'].toString());
          await pref.setString(AppConstants.STORAGE_USER_PROFILE_LABEL,
              result.data['label'].toString());
          GoRouter.of(context).go(AppRouter.employeeHomePath);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.data['message']),
            ),
          );
        } else {
          GoRouter.of(context).go(AppRouter.loginPath);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${result.body}'),
          ));
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Toggler(
                  // Add a Toggler widget to toggle between owner and employee login
                  labels: ['Owner', 'Employee'],
                  onToggle: (index) {
                    setState(() {
                      isOwner = index == 0;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Icon(Icons.gamepad, size: 100, color: Colors.green),
              SizedBox(height: 20),
              textField(
                  nameController: emailController,
                  label: 'Email',
                  keyType: TextInputType.emailAddress,
                  icon: Icon(Icons.email),
                  hide: false),
              textField(
                  nameController: passwordController,
                  label: 'Password',
                  keyType: TextInputType.visiblePassword,
                  icon: Icon(Icons.lock),
                  hide: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => login(),
                child: Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => context.go(AppRouter.registerPath),
                      child: Text('Create an account')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding textField(
      {required TextEditingController nameController,
      required label,
      required keyType,
      required icon,
      required hide}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: nameController,
        keyboardType: keyType,
        obscureText: hide,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
